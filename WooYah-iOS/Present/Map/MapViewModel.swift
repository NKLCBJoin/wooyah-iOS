//
//  MapViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/14.
//

import Foundation

import RxCocoa
import RxSwift

class MapViewModel:ViewModelType {
    
    var disposeBag = DisposeBag()
    let usecase: MapUsecaseProtocol
    let getCartList = PublishSubject<BaseResponse<MapDTO>>()
    let getCartIds = BehaviorRelay<[CartListDTO]>(value: [])
    let duplicationCarts = BehaviorRelay<[CartListDTO]>(value: [])
    let lat = BehaviorRelay<Double>(value: 0.0)
    let lng = BehaviorRelay<Double>(value: 0.0)

    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(usecase:MapUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
    
    func updateMapCartList(latitude: Double, longitude: Double) {
        usecase.getMapCartList(latitude: latitude, longitude: longitude)
              .subscribe(onSuccess: { [weak self] info in

                  guard let cartList = info.result?.data else {
                      return
                  }

                  // 좌표 갯수를 추적하기 위한 딕셔너리
                  var coordinateCounts: [String: Int] = [:]

                  // 중복된 좌표 모두 저장할 배열
                  var duplicatedCarts: [CartListDTO] = []
                  var duplicatedKey = ""
                  // 갯수에 기반하여 좌표 필터링
                  for i in 0..<cartList.count {
                      let coordinateKey = "\(cartList[i].latitude)_\(cartList[i].longitude)"
                      coordinateCounts[coordinateKey, default: 0] += 1

                      // 중복된 경우에만 duplicatedCarts에 추가
                      if let count = coordinateCounts[coordinateKey], count > 1 {
                         duplicatedKey = coordinateKey
                      }
                  }
                  for cart in cartList {
                      let check = "\(cart.latitude)_\(cart.longitude)"
                      if check == duplicatedKey {
                          duplicatedCarts.append(cart)
                      }
                  }


                  // 중복된 좌표로 duplicationCarts를 업데이트
                  self?.duplicationCarts.accept(duplicatedCarts)

                // 모든 좌표로 getCartIds를 업데이트
                self?.getCartIds.accept(cartList)

                // 나머지 코드 실행...
                self?.getCartList.onNext(info)
                  print(info)
            }, onFailure: { error in
                print("MapVM에러 발생: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
