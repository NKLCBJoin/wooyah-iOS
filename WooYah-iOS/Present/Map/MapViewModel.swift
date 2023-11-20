//
//  MapViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/14.
//

import Foundation
import RxSwift

class MapViewModel:ViewModelType {
    
    var disposeBag = DisposeBag()
    let usecase: MapUsecaseProtocol
    let getCartList = PublishSubject<BaseResponse<MapDTO>>()
    
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
    func updateMapCartList() {
        usecase.getMapCartList()
            .subscribe(onSuccess: { [weak self] info in
                print(info)
                self?.getCartList.onNext(info)
            }, onFailure: { error in
                print("MapVM에러 발생: \(error)")
            }
            )
            .disposed(by: disposeBag)
    }
}
