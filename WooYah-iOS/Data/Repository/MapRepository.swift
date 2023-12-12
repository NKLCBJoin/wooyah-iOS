//
//  MapRepository.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/20.
//

import Foundation
import RxSwift

protocol MapRepositoryInterface {
   func getMapCartList(latitude:Double, longitude:Double) -> Single<BaseResponse<MapDTO>>
}
final class MapRepository: MapRepositoryInterface {
    
    private let mapService : MapService
    
    func getMapCartList(latitude: Double, longitude: Double) -> RxSwift.Single<BaseResponse<MapDTO>> {
        return mapService.getMapCartList(latitude: latitude, longitude: longitude)
    }
    
    init(mapService: MapService) {
        self.mapService = mapService
    }
}
