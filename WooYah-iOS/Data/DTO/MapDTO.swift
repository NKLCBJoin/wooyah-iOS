//
//  MapDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation

struct MapDTO: Codable {
    let count: Int
    let data: [CartListDTO]
}
struct CartListDTO: Codable {
    let cartId: Int  // "cartId"로 수정
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case cartId = "cartId"  // JSON의 키와 속성명이 다르므로 CodingKeys를 사용하여 매핑
        case latitude
        case longitude
    }
}
