//
//  BaseResponse.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/18.
//

import Foundation

struct BaseResponse<Result: Decodable>: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

struct BaseArrayResponse<Result: Decodable>: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Result]?
}
