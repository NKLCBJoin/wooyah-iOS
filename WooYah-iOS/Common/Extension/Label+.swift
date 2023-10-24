//
//  Label+.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import Foundation
import UIKit

extension UILabel {
    func bold(targetString: String) {
            let fontSize = self.font.pointSize
            let font = UIFont(name: "SUIT-Bold", size: fontSize)
            let fullText = self.text ?? ""
            let range = (fullText as NSString).range(of: targetString)
            let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font as Any, range: range)
            self.attributedText = attributedString
    }
}
