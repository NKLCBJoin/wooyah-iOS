//
//  NSMutableAttributedString+.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import Foundation
import UIKit

extension NSMutableAttributedString {

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont(name: "SUIT-Bold", size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font as Any]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
