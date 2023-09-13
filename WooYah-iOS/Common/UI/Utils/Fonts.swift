//
//  Fonts.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import Foundation
import UIKit

extension UIFont {
    public enum PretendardType: String {
        case Bold = "Bold"
        case Medium = "Medium"
        case Regular = "Regular"
        case ExtraBold = "ExtraBold"
        case Heavy = "Heavy"
        case Light = "Light"
        case Thin = "Thin"
        case SemiBold = "SemiBold"
    }
    static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "SUIT-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
