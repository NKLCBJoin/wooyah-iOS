//
//  Utils.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/08.
//

import Foundation
import UIKit

class Utils {
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
