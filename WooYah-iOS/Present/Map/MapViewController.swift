//
//  MapViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit
import NMapsMap
import RxCocoa

class MapViewController: BaseViewController {
    
    private let viewModel: MapViewModel!
    
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
    override func configure() {
        
    }
    
    override func addview() {
        self.view.addSubview(naverMapView)
        self.naverMapView.addSubview(searchBtn)
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
    }
    
    override func setupBinding() {
        self.searchBtn.rx.tap
            .asDriver()
            .flatMap { [weak self] _ -> Driver<String> in
                guard let self = self else { return Driver.empty() } // 클로저가 실행되는 동안 self가 nil이라면 빈 Driver 반환

                let vc = SearchAddressViewController()
                self.present(vc, animated: true, completion: nil)

                vc.coordinateSubject
                    .subscribe(onNext: { [weak self] coordinates in
                        guard let self = self else { return }

                        print("Coordinate Updated: \(coordinates)")
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

    }
    
    private func moveLocate(lat:Double, lng:Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
    }

    init(_ viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
