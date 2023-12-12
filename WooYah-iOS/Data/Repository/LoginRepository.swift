//
//  LoginRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

final class LoginRepository: LoginRepositoryType {
    
    private let loginService: LoginService
    
    init(service: LoginService) {
        self.loginService = service
    }
    
    func requestLogin(user: LoginUserRequest) -> RxSwift.Single<BaseResponse<Empty>> {
        return loginService.requestLogin(user: user)
    }
}
