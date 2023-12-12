//
//  ProductService.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift
import Alamofire

class ProductService{
    func fetchProductDetail(id:Int) -> Single<BaseResponse<ProductDTO>> {
        let url = APIConstants.baseURL + "cart/\(id)"
        return Single<BaseResponse<ProductDTO>>.create { observer in
            AF.request(url)
                .responseDecodable(of: BaseResponse<ProductDTO>.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        observer(.failure(error))
                        print(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func WriteCart(product: WriteProductDTO) -> Single<BaseResponse<Empty>> {
        let url = APIConstants.baseURL + "cart"
        return Single<BaseResponse<Empty>>.create { observer in
            
            let headers: HTTPHeaders = [
                 "Content-Type": "application/json",
                 "Authorization": UserDefaults.standard.string(forKey: "AccessToken")!
             ]
            
            AF.request(url, method: .post,parameters: product, encoder: JSONParameterEncoder.default, headers: headers)
                .responseDecodable(of: BaseResponse<Empty>.self) { res in
                    switch res.result {
                    case .success(let response):
                        print(response)
                        observer(.success(response))
                    case .failure(let error):
                        observer(.failure(error))
                        print("글작성 에러: \(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
