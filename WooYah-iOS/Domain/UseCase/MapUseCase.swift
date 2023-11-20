//
//  MapUsecase.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation
import RxSwift

protocol MapUsecaseProtocol {
    func getMapCartList() -> Single<BaseResponse<MapDTO>>
}
class MapUseCase:MapUsecaseProtocol {
    
    private let repository: MapRepository
    
    func getMapCartList() -> RxSwift.Single<BaseResponse<MapDTO>> {
        return repository.getMapCartList()
    }
    
    init(repository: MapRepository) {
        self.repository = repository
    }
    
}
