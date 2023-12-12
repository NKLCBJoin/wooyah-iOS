//
//  LoginDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/14.
//
import Foundation

struct LoginUserRequest: Encodable {
    let email: String?
    let nickname: String?
    let location: String?
    let phone: String?
    let device_number: String?
}



