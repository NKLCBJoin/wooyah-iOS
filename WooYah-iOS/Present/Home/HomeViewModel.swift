//
//  HomeViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import Foundation

import RxCocoa
import RxSwift

class HomeViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    private let usecase: HomeUseCaseProtocol
    let homeList = BehaviorRelay<[DetailInfo]>(value: [])
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(usecase: HomeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
    
    func updateProductList(){
        usecase.fetchHomeProductList()
            .subscribe(onSuccess: {  [weak self]  list in
                self?.homeList.accept((list.result?.data)!)
            })
            .disposed(by: disposeBag)
    }
}
