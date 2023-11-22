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
    let dummyList = BehaviorRelay<[MyPageDummy]>(value: [])

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
    
    func updateDummy() {
        print("더미업데이트")
        dummyList.accept([
            MyPageDummy(cartId: 1, locate: "금오공대", personCount: 3),
            MyPageDummy(cartId: 2, locate: "구미 홈플러스", personCount: 5)
        ])
    }

    func deleteItem(at indexPath: IndexPath) {
        var currentList = dummyList.value
        currentList.remove(at: indexPath.row)
        dummyList.accept(currentList)
    }

}
