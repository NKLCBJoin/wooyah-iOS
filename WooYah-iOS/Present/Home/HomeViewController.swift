//
//  HomeViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import UIKit

class HomeViewController: BaseViewController {
    private let topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = UIColor(hexString: "#222222")
        return view
    }()
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요.\n닉네임님!"
        label.font = .pretendard(.Bold, size: 18)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.numberOfLines = 0
        return label
    }()

    override func configure() {
        
    }
    
    override func addview() {
        self.view.addSubview(topView)
        self.topView.addSubview(welcomeLabel)
    }
    override func layout() {
        self.topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(178)
        }
        self.welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalToSuperview().offset(30)
        }
    }
}
