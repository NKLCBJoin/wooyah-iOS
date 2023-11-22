//
//  MapViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit
import NMapsMap
import RxCocoa
import RxSwift

class MapViewController: BaseViewController {
    
    private let viewModel: MapViewModel!
    
    let infoWindow = NMFInfoWindow()
    let datasource = NMFInfoWindowDefaultTextSource.data()
    let marker = NMFMarker()
    
    private let showCartList = PublishSubject<Bool>()
    
    private let cartListTabelView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.cornerRadius = 5
        $0.layer.shadowRadius = 5 //반경
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        
    }
    private let searchBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#CCCCCC").withAlphaComponent(0.6)
        $0.setTitle(" 장소를 검색해주세요.", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.titleLabel?.font = .pretendard(.SemiBold, size: 15)
        $0.setTitleColor(UIColor(hexString: "#222222"), for: .normal)
        $0.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        $0.tintColor = UIColor(hexString: "#222222")
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
    }
    private var naverMapView = NMFMapView().then {
        $0.allowsZooming = true
        $0.logoInteractionEnabled = false
        $0.allowsScrolling = true // 스크롤 가능
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.updateMapCartList()
    }
    
    override func configure() {
        moveLocate(lat: 36.1451773, lng: 128.393913)
        naverMapView.isTiltGestureEnabled = false
        naverMapView.isRotateGestureEnabled = false
        naverMapView.touchDelegate = self
        cartListTabelView.isHidden = true
    }
    
    override func addview() {
        self.view.addSubview(naverMapView)
        self.naverMapView.addSubview(searchBtn)
        self.naverMapView.addSubview(cartListTabelView)
    }
    
    override func layout() {
        self.naverMapView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(42)
        }
        self.cartListTabelView.snp.makeConstraints { make in
            make.top.equalTo(self.naverMapView.snp.top).offset(50) // 예시: 위에서 50 포인트 떨어진 위치
            make.leading.equalTo(self.naverMapView.snp.leading).offset(16) // 예시: 왼쪽에서 16 포인트 떨어진 위치
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
    }
    
    override func setupBinding() {
        self.searchBtn.rx.tap
            .asDriver()
            .flatMap { [weak self] _ -> Driver<String> in
                guard let self = self else { return Driver.empty() } 

                let vc = SearchAddressViewController()
                self.present(vc, animated: true, completion: nil)

                vc.coordinateSubject
                    .subscribe(onNext: { [weak self] coordinates in
                        guard let self = self else { return }
                        guard let lat = coordinates.first, let lng = coordinates.last else {
                            return
                        }
                        self.moveLocate(lat: lat, lng: lng)
                    })
                    .disposed(by: self.disposeBag)

                return vc.locateSubject.asDriver(onErrorJustReturn: "")
            }
            .drive(searchBtn.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        self.cartListTabelView.rx.modelSelected(CartListDTO.self)
            .bind(onNext: { [weak self] cell in
                self?.pushDetailCart(id: cell.cartId)
            })
            .disposed(by: disposeBag)
        
        viewModel.getCartList
            .bind(onNext: { [weak self] cart in
                self?.showCounts(count: cart.result?.count ?? 0)
            }).disposed(by: disposeBag)
        
        viewModel.getCartIds
            .bind(to: self.cartListTabelView.rx.items(cellIdentifier: DropDownTableViewCell.identifier, cellType:DropDownTableViewCell.self))
        {   index, item, cell in
            print(item)
            cell.selectionStyle = .none
            cell.configureCell(item)
        }
            .disposed(by: disposeBag)
        
        self.showCartList
            .subscribe(onNext: { [weak self] shouldShow in
                guard let self = self else { return }
                if shouldShow {
                    // 마커 위치에 따라 동적으로 조절
                    let markerPosition = self.getMarkerPosition()
                    self.cartListTabelView.snp.updateConstraints { make in
                        make.top.equalTo(self.naverMapView.snp.top).offset(markerPosition.y)
                        make.leading.equalTo(self.naverMapView.snp.leading).offset(markerPosition.x)
                    }
                    // 테이블뷰 나타내기
                    self.cartListTabelView.isHidden = false
                } else {
                    // 테이블뷰 숨기기
                    self.cartListTabelView.isHidden = true
                }
            })
            .disposed(by: disposeBag)

    }
    
    private func showCounts(count: Int) {
        let countStr = String(count) + "개"
        datasource.title = countStr
        infoWindow.dataSource = datasource
        infoWindow.open(with: marker)
    }
    
    private func moveLocate(lat:Double, lng:Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = naverMapView
        infoWindow.alpha = 0.6
        infoWindow.open(with: marker)
    }
    
    private func getMarkerPosition() -> CGPoint {
        let markerPoint = naverMapView.projection.point(from: marker.position)
        return CGPoint(x: markerPoint.x, y: markerPoint.y)
    }

    init(_ viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MapViewController {
    private func pushDetailCart(id:Int) {
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: false,completion: nil)
    }
}
extension MapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            print("마커 터치")
            self.showCartList.onNext(true)
            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
        }
        self.showCartList.onNext(false)
        print("지도 탭")
    }
}

