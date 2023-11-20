//
//  MapRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation
import RxSwift

protocol MapRepositoryInterface {
    func getMapCartList() -> Single<BaseResponse<MapDTO>>
}

class MapRepository: MapRepositoryInterface {
    
    private let mapService : MapService
    
    func getMapCartList() -> RxSwift.Single<BaseResponse<MapDTO>> {
        return mapService.getMapCartList()
    }
    
    init(mapService: MapService) {
        self.mapService = mapService
    }
}
