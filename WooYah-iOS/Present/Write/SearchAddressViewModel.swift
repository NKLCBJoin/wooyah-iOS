//
//  SearchAddressViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/31.
//

import Foundation
import RxSwift

class SearchAddressViewModel:ViewModelType {

    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    var disposeBag: DisposeBag

    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
}
