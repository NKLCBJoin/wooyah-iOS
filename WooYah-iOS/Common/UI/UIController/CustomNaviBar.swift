//
//  CustomNaviBar.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/17.
//

import UIKit
import Then

@objc
protocol CustomNaviBarDelegate{
    func backBtnClick(_ navibar:CustomNaviBar)
}

class CustomNaviBar: BaseView {
    
    weak var delegate: CustomNaviBarDelegate?
    
    public var navititleLabel = UILabel().then{
        $0.text = "페이지정보"
        $0.font = .pretendard(.Bold, size: 18)
//        $0.textColor = UIColor(rgb: 0x333333)
    }
    public let backBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }


    override func configure() {
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
    }
    
    override func addview() {
        self.addSubview(backBtn)
        self.addSubview(navititleLabel)
    }
    
    override func layout() {
        self.navititleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }

    }
}
extension CustomNaviBar {
    @objc func backBtnClick(){
        self.delegate?.backBtnClick(self)
    }
}
