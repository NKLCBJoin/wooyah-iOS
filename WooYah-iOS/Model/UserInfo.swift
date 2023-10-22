//
//  UserInfo.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/21.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()
    
    var name: String?
    var phone: String?
    var address: String?
    
    private init() {}
}
