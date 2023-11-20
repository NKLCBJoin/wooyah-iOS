//
//  MyPageViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    private let naviBar:CustomNaviBar = CustomNaviBar(frame: .zero)
    private let welecomImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "hi")
        $0.backgroundColor = .clear
    }
    private let nameLabel = UILabel().then {
        $0.text = "xx님, 안녕하세요."
        $0.font = .pretendard(.SemiBold, size: 20)
        $0.textColor = UIColor(hexString: "#666666")
        $0.sizeToFit()
    }
    
    override func configure() {
        naviBar.backBtn.isHidden = true
        naviBar.navititleLabel.text = "마이페이지"
    }
    
    override func addview() {
        self.view.addSubview(naviBar)
        self.view.addSubview(welecomImg)
        self.view.addSubview(nameLabel)
    }
    
    override func layout() {
        self.naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.welecomImg.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(120)
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(welecomImg.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
}
