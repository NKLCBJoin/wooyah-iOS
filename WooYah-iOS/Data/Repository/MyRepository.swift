//
//  MyRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/10.
//

import Foundation
import RxSwift

final class MyRepository: MyRepositoryType {
    
    private let service: MyService
    
    init(service: MyService) {
        self.service = service
    }
    
    func fetchMyCarts(jwt: String) -> RxSwift.Single<BaseResponse<MyCartDTO>> {
        return service.fetchMyCarts(jwt: jwt)
    }
    
    func deleteCart(id:Int) -> Single<BaseResponse<Empty>> {
        return service.deleteCart(id: id)
    }
}
