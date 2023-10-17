//
//  Error.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/14.
//

import Foundation

enum AuthError: Error {
    case invalidURL
    case serverError
    case oauthFailed
    case unknownUser
    case passwordFaild
}
