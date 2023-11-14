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
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
