//
//  HomeUseCase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/11.
//

import Foundation

import RxSwift

protocol HomeUseCaseProtocol {
    func fetchHomeProductList() -> Single<BaseResponse<HomeList>>
}
final class HomeUseCase: HomeUseCaseProtocol{
    
    let repsoitory: HomeRepositoryType
    
    init(repsoitory: HomeRepositoryType) {
        self.repsoitory = repsoitory
    }
    
    func fetchHomeProductList() -> RxSwift.Single<BaseResponse<HomeList>> {
        return repsoitory.fetchHomeProductList()
    }
}
