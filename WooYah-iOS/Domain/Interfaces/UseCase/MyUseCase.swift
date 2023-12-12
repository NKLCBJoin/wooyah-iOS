//
//  MyUseCase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/10.
//

import Foundation

import RxSwift

protocol MyUseCaseProtocol {
    func fetchMyCarts(jwt: String) -> Single<BaseResponse<MyCartDTO>>
    func deleteCart(id:Int) -> Single<BaseResponse<Empty>>
}
final class MyUseCase: MyUseCaseProtocol {
    
    private let repository: MyRepositoryType
    
    init(repository: MyRepositoryType) {
        self.repository = repository
    }

    func fetchMyCarts(jwt: String) -> RxSwift.Single<BaseResponse<MyCartDTO>> {
        return repository.fetchMyCarts(jwt: jwt)
    }
    
    func deleteCart(id: Int) -> RxSwift.Single<BaseResponse<Empty>> {
        return repository.deleteCart(id: id)
    }
}
