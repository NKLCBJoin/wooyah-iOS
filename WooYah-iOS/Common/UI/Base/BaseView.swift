//
//  BaseView.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/18.
//

import UIKit

class BaseView: UIView {

    func layout() {}
    func configure() {}
    func addview() {}
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addview()
        self.configure()
        self.layout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
