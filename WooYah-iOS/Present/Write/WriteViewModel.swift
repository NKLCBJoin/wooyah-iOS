//
//  WriteViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import Foundation
import RxSwift

class WriteViewModel:ViewModelType {
    func transform(input: Input) -> Output {
        return Output()
    }
    
    var disposeBag: DisposeBag
    

    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
    struct Input {
        
    }
    struct Output {
        
    }
}
