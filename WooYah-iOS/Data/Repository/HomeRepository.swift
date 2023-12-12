//
//  HomeRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/11.
//

import Foundation

import RxSwift

final class HomeRepository: HomeRepositoryType {
    
    private let service: HomeService
    
    init(service: HomeService) {
        self.service = service
    }
    
    func fetchHomeProductList() -> RxSwift.Single<BaseResponse<HomeList>> {
        return service.fetchHomeProductList()
    }
}
 
