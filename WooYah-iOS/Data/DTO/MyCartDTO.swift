//
//  MyCartDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/09.
//

import Foundation

struct MyCartDTO: Decodable {
    let count: Int
    let data: [ProductInfoDTO]
}

struct ProductInfoDTO: Decodable {
    let cartId: Int
    let shoppingLocation: String
    let participantNumber: Int
}
