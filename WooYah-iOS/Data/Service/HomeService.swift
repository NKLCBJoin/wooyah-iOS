//
//  HomeService.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation

import RxSwift
import Alamofire

class HomeService {
    func fetchHomeProductList() -> Single<BaseResponse<HomeList>> {
        let url = APIConstants.baseURL + "cart/home"
        
        return Single<BaseResponse<HomeList>>.create { observer in
            AF.request(url)
                .responseDecodable(of: BaseResponse<HomeList>.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("HomeAPI 에러:\(error)")
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("HomeAPI에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
        }
    }
}
