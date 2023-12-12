//
//  MapUsecase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation
import RxSwift

protocol MapUsecaseProtocol {
    func getMapCartList(latitude:Double, longitude:Double) -> Single<BaseResponse<MapDTO>>
}
final class MapUseCase:MapUsecaseProtocol {
    
    private let repository: MapRepository
    
    func getMapCartList(latitude: Double, longitude: Double) -> RxSwift.Single<BaseResponse<MapDTO>> {
        return repository.getMapCartList(latitude: latitude, longitude: longitude)
    }
    
    init(repository: MapRepository) {
        self.repository = repository
    }
    
}
