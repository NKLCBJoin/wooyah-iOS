//
//  Button+.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/18.
//

import Foundation
import UIKit

extension UIButton{
    enum State {
        case disabled
        case enabled
        
        var backgroundColor: UIColor? {
            switch self {
            case .enabled:
                return UIColor(hexString: "#1F4EF6")
            case .disabled:
                return UIColor(hexString: "#DDDDE3")
            }
        }
        
        var foregroundColor: UIColor? {
            switch self {
            case .enabled:
                return UIColor(hexString: "#FFFFFF")
            case .disabled:
                return UIColor(hexString: "#8B8B91")
            }
        }
    }
    func setNextButtonState(state: State) {
        self.backgroundColor = state.backgroundColor
        self.setTitleColor(state.foregroundColor, for: .normal)
        self.isEnabled = (state == .enabled)
        
    }
    
}

