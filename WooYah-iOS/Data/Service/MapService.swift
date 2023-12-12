//
//  MapService.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation
import RxSwift
import Alamofire

class MapService {
    func getMapCartList(latitude:Double, longitude:Double) -> Single<BaseResponse<MapDTO>> {
        let url = APIConstants.baseURL + "cart/near?latitude=\(latitude)&longitude=\(longitude)&zoom=\(1)"
        
        return Single<BaseResponse<MapDTO>>.create { observer in
            AF.request(url)
                .responseDecodable(of: BaseResponse<MapDTO>.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("Map API 에러:\(error)")
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("Map API에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchNearCartList(lat:Double, lng:Double) -> Single<BaseResponse<MapDTO>>  {
        let url = APIConstants.baseURL + "cart/locations"
        
        return Single<BaseResponse<MapDTO>>.create { observer in
            AF.request(url)
                .responseDecodable(of: BaseResponse<MapDTO>.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("Map API 에러:\(error)")
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("Map API에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
        }
    }}
