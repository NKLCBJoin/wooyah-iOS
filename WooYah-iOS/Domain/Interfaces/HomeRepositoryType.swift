//
//  HomeRepositoryType.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/11.
//

import Foundation

import RxSwift

protocol HomeRepositoryType {
    func fetchHomeProductList() -> Single<BaseResponse<HomeList>>
}
