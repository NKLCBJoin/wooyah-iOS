//
//  ProductRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

final class ProductRepository: ProductRepositortyType {
    
    let service: ProductService
    
    init(service: ProductService) {
        self.service = service
    }
    
    func fetchProductDetail(with id: Int) -> RxSwift.Single<BaseResponse<ProductDTO>> {
        return service.fetchProductDetail(id: id)
    }
    
    func WriteCart(with product: WriteProductDTO) -> Single<BaseResponse<Empty>> {
        return service.WriteCart(product: product)
    }
}
