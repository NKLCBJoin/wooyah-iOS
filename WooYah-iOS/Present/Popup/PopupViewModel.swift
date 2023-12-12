//
//  PopupViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import RxSwift

class PopupViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase:ProductUseCaseProtocol
    let productDetail = PublishSubject<[Products]>()
    let detail = PublishSubject<BaseResponse<ProductDTO>>()
    
    struct Input {
        
    }
    
    struct Output {
        
    }

    init( usecase: ProductUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()

        return output
    }
    
    func updateInfo(id:Int) {
        usecase.fetchProductDetail(with: id)
            .subscribe(onSuccess: { [weak self] info in
                self?.detail.onNext(info)
                self?.productDetail.onNext(info.result!.products)
            })
            .disposed(by: disposeBag)
    }
}
