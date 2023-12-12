//
//  MyService.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/09.
//

import Foundation

import RxSwift
import Alamofire

class MyService {
    func fetchMyCarts(jwt: String) -> Single<BaseResponse<MyCartDTO>>  {
        let url = APIConstants.baseURL + "user/mypage"
        let parameters: [String: Any] = [
            "page": 0,
            "size": 5,
            "sort": ["DESC"]
        ]
        let headers: HTTPHeaders = [
            "Authorization": jwt
        ]
        
        return Single<BaseResponse<MyCartDTO>>.create { observer in
            AF.request(url, method: .get, parameters: parameters, headers: headers)
                .responseDecodable(of: BaseResponse<MyCartDTO>.self) { res in
                    switch res.result {
                    case .success(let response):
                        print(response)
                        observer(.success(response))
                    case .failure(let error):
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("MyCartAPI에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    func deleteCart(id:Int) -> Single<BaseResponse<Empty>> {
        let url = APIConstants.baseURL + "cart?cartId=\(id)"
        let headers: HTTPHeaders = [
             "Authorization": UserDefaults.standard.string(forKey: "AccessToken")!
         ]
        
        return Single<BaseResponse<Empty>>.create { observer in
            AF.request(url, method: .delete, headers: headers)
                .responseDecodable(of: BaseResponse<Empty>.self) { res in
                    debugPrint(res)
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        observer(.failure(error))
                        print("삭제에러\(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
