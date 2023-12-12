//
//  HomeDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/11.
//

import Foundation

struct HomeList: Decodable {
    let count: Int
    let data: [DetailInfo]
}

struct DetailInfo: Decodable {
    let cartId: Int
    let ownerPhoneNumber: String
    let nickname: String
    let shoppingLocation: String
    let products: [Products]
}
