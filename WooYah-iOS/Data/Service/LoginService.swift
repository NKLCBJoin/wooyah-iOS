//
//  LoginService.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift
import Alamofire

class LoginService {
    func requestLogin(user: LoginUserRequest) -> Single<BaseResponse<Empty>> {
        return Single.create { single in
            let requestURL = APIConstants.baseURL + "auth/kakao"
            
            AF.request(requestURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: BaseResponse<Empty>.self) { response in
                    switch response.result {
                    case .success(let data):
                        if let headers = response.response?.allHeaderFields as? [String: String],
                                let token = headers["Authorization"] {
                                   print(token)
                                   UserDefaults.standard.set(token, forKey: "AccessToken")
                               }
                        single(.success(data))
                    case .failure(let error):
                        print("로그인error:\(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
