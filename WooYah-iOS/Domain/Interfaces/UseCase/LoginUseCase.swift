//
//  LoginUseCase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol {
    func requestLogin(user: LoginUserRequest) -> Single<BaseResponse<Empty>>
}
final class LoginUseCase: LoginUseCaseProtocol {
    
    private let loginRepository: LoginRepositoryType
    
    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }
    
    func requestLogin(user: LoginUserRequest) -> RxSwift.Single<BaseResponse<Empty>> {
        return loginRepository.requestLogin(user: user)
    }
}
