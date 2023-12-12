//
//  InputPhoneViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class InputPhoneViewModel: ViewModelType {
    var disposeBag: DisposeBag
    private let userinfo = UserInfo.self
    private let registerPublisher = PublishSubject<Void>()

    struct Input {
        let phoneNumberText: Observable<String>
        let nextBtnTap: Signal<Void>
    }
    struct Output {
        let isValidPhone: Observable<Bool>
        let nextBtnTap: Signal<Void>
        let registerPublisher: PublishSubject<Void>
    }

    func transform(input: Input) -> Output {
        let isValidPhone = input.phoneNumberText.map { self.isValidPhoneNumber($0) }.asObservable()
        
        input.nextBtnTap.asObservable()
            .withLatestFrom(input.phoneNumberText).subscribe(onNext: { phonenum in
                self.userinfo.shared.phone = phonenum
            }).disposed(by: disposeBag)

        return Output(isValidPhone: isValidPhone,nextBtnTap:input.nextBtnTap, registerPublisher: registerPublisher)
    }

    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        return phoneNumber.count == 11
    }

    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
}

