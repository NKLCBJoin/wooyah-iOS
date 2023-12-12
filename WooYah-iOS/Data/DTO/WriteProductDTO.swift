//
//  WriteProductDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/11.
//

import Foundation

struct WriteProductDTO: Encodable {
    let location: String
    let participantNumber: Int
    let latitude: Double
    let longitude: Double
    let products: [String]
}
