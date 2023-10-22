//
//  LoginDTO.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/14.
//
import Foundation

struct AppleUser {
    let userIdentifier: String?
    let familyName: String?
    let givenName: String?
    let email: String?
    let phone: Int?
}
struct KakaoUser {
    let token: String?
    let name: String?
    let phonenum: Int?
}
struct NaverUser {
    let Id: String?
    let Name: String?
    let Phone: Int?
}
