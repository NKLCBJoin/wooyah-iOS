//
//  dummy.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import RxDataSources

struct MyPageDummy {
    let cartId: Int
    let locate: String
    let personCount: Int
}

struct CartItemDummy {
    let cartId: Int
    let locate: String
    let username: String
    let itmes: [String]
    let personCount: Int
}
