//
//  MapDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation

struct MapDTO: Decodable {
    let count: Int
    let data: [CartListDTO]
}
struct CartListDTO: Decodable {
    let cartId: Int  
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case cartId = "cartId"
        case latitude
        case longitude
    }
}
