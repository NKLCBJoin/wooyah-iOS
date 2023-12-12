//
//  MyPageViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/14.
//

import Foundation
import RxSwift
import RxRelay

class MyPageViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: MyUseCaseProtocol
    let myList = BehaviorRelay<[ProductInfoDTO]>(value: [])

    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(usecase: MyUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
    
    func updateMyList(jwt: String) {
        usecase.fetchMyCarts(jwt: jwt)
            .subscribe(onSuccess: { [weak self]  info  in
                self?.myList.accept(info.result!.data)
            })
            .disposed(by: disposeBag)
    }
    

    func deleteItem(cartId: Int) {
        usecase.deleteCart(id: cartId)
            .subscribe(onSuccess: {  [weak self]  info in
                self?.myList.accept(self?.myList.value.filter { $0.cartId != cartId } ?? [])
            })
            .disposed(by: disposeBag)
    }

}
