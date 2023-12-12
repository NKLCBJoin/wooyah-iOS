//
//  ProductRepositortyType.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import RxSwift

protocol ProductRepositortyType: AnyObject {
    func fetchProductDetail(with id: Int) -> Single<BaseResponse<ProductDTO>>
    func WriteCart(with product: WriteProductDTO) -> Single<BaseResponse<Empty>>
}
