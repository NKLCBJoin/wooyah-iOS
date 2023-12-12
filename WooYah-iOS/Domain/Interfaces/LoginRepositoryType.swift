//
//  LoginRepositoryType.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

protocol LoginRepositoryType:AnyObject {
    func requestLogin(user: LoginUserRequest) -> Single<BaseResponse<Empty>>
}
