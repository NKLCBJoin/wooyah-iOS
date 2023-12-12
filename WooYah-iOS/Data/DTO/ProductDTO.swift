//
//  ProductDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation

struct ProductDTO: Decodable {
    let cartId: Int
    let nickname: String
    let shoppingLocation: String
    let products: [Products]
    let cartStatus: String
    let ownerPhoneNumber: String
}

struct Products: Decodable {
    let productId: Int
    let productName: String
}
