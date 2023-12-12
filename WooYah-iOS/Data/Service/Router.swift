//
//  Router.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/05.
//

import Foundation
import Alamofire

public protocol Router {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding? { get }
}

