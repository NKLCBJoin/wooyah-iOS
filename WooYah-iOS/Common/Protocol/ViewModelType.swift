//
//  ViewModelType.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
