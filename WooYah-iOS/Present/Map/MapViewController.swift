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
    private var marker: [NMFMarker] = []

    private let showCartList = PublishSubject<Bool>()
    private let listCountLabel = UILabel().then {
        $0.text = "현재 근처의 공고는 0개"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = .black
        $0.sizeToFit()
    }
    
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
        self.viewModel.updateMapCartList(latitude: viewModel.lat.value, longitude: viewModel.lng.value)
    }
    
    override func configure() {
        naverMapView.isTiltGestureEnabled = false
        naverMapView.isRotateGestureEnabled = false
        naverMapView.touchDelegate = self
        cartListTabelView.isHidden = true
        self.viewModel.lat.accept(36.145177)
        self.viewModel.lng.accept(128.393913)
        self.viewModel.updateMapCartList(latitude: 36.145177, longitude: 128.393913)
        self.moveLocate(lat: 36.145177, lng: 128.393913)
    }
    
    override func addview() {
        self.view.addSubview(naverMapView)
        self.naverMapView.addSubview(searchBtn)
        self.naverMapView.addSubview(cartListTabelView)
        self.naverMapView.addSubview(listCountLabel)
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
            make.top.equalTo(self.naverMapView.snp.top).offset(50)
            make.leading.equalTo(self.naverMapView.snp.leading).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        self.listCountLabel.snp.makeConstraints {
            $0.top.equalTo(searchBtn.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
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
                        self.viewModel.lat.accept(lat)
                        self.viewModel.lng.accept(lng)
                        self.viewModel.updateMapCartList(latitude: lat, longitude: lng)
                        self.moveLocate(lat: lat, lng: lng)
                    })
                    .disposed(by: self.disposeBag)

                return vc.locateSubject.asDriver(onErrorJustReturn: "")
            }
            .drive(searchBtn.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        self.cartListTabelView.rx.modelSelected(CartListDTO.self)
            .bind(onNext: { [weak self] cell in
                self?.showPopupViewController(id: cell.cartId)
            })
            .disposed(by: disposeBag)
        
        viewModel.duplicationCarts
            .bind(to: self.cartListTabelView.rx.items(cellIdentifier: DropDownTableViewCell.identifier, cellType:DropDownTableViewCell.self))
        {   index, item, cell in
            cell.selectionStyle = .none
            cell.configureCell(item)
        }
            .disposed(by: disposeBag)
        
        viewModel.getCartIds
            .bind(onNext: { [weak self] cartList in
                guard let self = self else { return }
                var coordinateCounts: [String: Int] = [:]

                self.listCountLabel.text = "현재 근처 올라온 공고는 \(cartList.count)개"
                self.marker.forEach { $0.mapView = nil }
                self.marker.removeAll()

                for cart in cartList {
                    let coordinateKey = "\(cart.latitude)_\(cart.longitude)"
                    coordinateCounts[coordinateKey, default: 0] += 1

                    let marker = NMFMarker()
                    marker.position = NMGLatLng(lat: cart.latitude, lng: cart.longitude)
                    marker.mapView = self.naverMapView
                    marker.userInfo = [
                        "cartId": cart.cartId,
                        "latitude": cart.latitude,
                        "longitude": cart.longitude
                    ]
                    self.marker.append(marker)

                    if let count = coordinateCounts[coordinateKey], count > 1 {
                        self.showCounts(count: count, marker: marker)
                    }
                }

                self.cartListTabelView.reloadData()
            })
            .disposed(by: disposeBag)


        
        self.showCartList
            .subscribe(onNext: { [weak self] shouldShow in
                guard let self = self else { return }
                if shouldShow {
                    // Calculate the average marker position
                    let markerPositions = self.getMarkerPositions()
                    let averageX = markerPositions.map { $0.x }.reduce(0, +) / CGFloat(markerPositions.count)
                    let averageY = markerPositions.map { $0.y }.reduce(0, +) / CGFloat(markerPositions.count)

                    // 마커 위치에 따라 동적으로 조절
                    self.cartListTabelView.snp.updateConstraints { make in
                        make.top.equalTo(self.naverMapView.snp.top).offset(averageY)
                        make.leading.equalTo(self.naverMapView.snp.leading).offset(averageX)
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
    
    private func showCounts(count: Int, marker: NMFMarker) {
        let infoWindow = NMFInfoWindow()
        let datasource = NMFInfoWindowDefaultTextSource.data()
        
        let countStr = "\(count)개"
        datasource.title = countStr
        infoWindow.dataSource = datasource
        infoWindow.alpha = 0.6
        infoWindow.open(with: marker)
    }

    private func moveLocate(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
                
    }

    private func findMarkerForPosition(_ position: NMGLatLng) -> NMFMarker? {
        for marker in marker {
            if marker.position == position {
                return marker
            }
        }
        return nil
    }

    private func getMarkerPositions() -> [CGPoint] {
        return marker.map { marker in
            let markerPoint = naverMapView.projection.point(from: marker.position)
            return CGPoint(x: markerPoint.x, y: markerPoint.y)
        }
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
    private func showPopupViewController(id: Int) {
        let vc = PopupViewController(viewModel: PopupViewModel(usecase:ProductUseCase(repository: ProductRepository(service: ProductService()))), id: id)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: false,completion: nil)
    }
}
extension MapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        // Remove existing touch handlers for all markers
        marker.forEach { marker in
            marker.touchHandler = nil
        }

        // Set touch handler for all markers to show the cart list
        marker.forEach { marker in
            marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                if let cartId = marker.userInfo["cartId"] as? Int {
                    if marker.infoWindow != nil {
                        self.showCartList.onNext(true)
                    }
                    else {
                        self.showPopupViewController(id: cartId)
                    }
                }
                return true
            }
        }

        // If no marker is tapped, hide the cart list
        self.showCartList.onNext(false)
        print("지도 탭")
    }
}



