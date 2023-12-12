//
//  ProductUseCase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

protocol ProductUseCaseProtocol: AnyObject {
    func fetchProductDetail(with id: Int) -> Single<BaseResponse<ProductDTO>>
    func WriteCart(with product: WriteProductDTO) -> Single<BaseResponse<Empty>>
}

final class ProductUseCase: ProductUseCaseProtocol {
    let repository: ProductRepositortyType
    
    init(repository: ProductRepositortyType) {
        self.repository = repository
    }
    
    func fetchProductDetail(with id: Int) -> RxSwift.Single<BaseResponse<ProductDTO>> {
        return repository.fetchProductDetail(with: id)
    }
    
    func WriteCart(with product: WriteProductDTO) -> Single<BaseResponse<Empty>> {
        return repository.WriteCart(with: product)
    }
}
