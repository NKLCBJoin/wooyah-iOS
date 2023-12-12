//
//  MyRepositoryType.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/10.
//

import Foundation
import RxSwift

protocol MyRepositoryType {
    func fetchMyCarts(jwt: String) -> Single<BaseResponse<MyCartDTO>>
    func deleteCart(id:Int) -> Single<BaseResponse<Empty>>
}
