//
//  CustomNaviBar.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/17.
//

import UIKit

@objc
protocol CustomNaviBarDelegate{
    func backBtnClick(_ navibar:CustomNaviBar)
    func searchBtnClick(_ navibar:CustomNaviBar)
}

class CustomNaviBar: BaseView {
    
    weak var delegate: CustomNaviBarDelegate?
    
    public var navititleLabel: UILabel {
        let label = UILabel()
        label.text = "페이지정보"
        label.font = .pretendard(.Bold, size: 18)
//        label.textColor = UIColor(rgb: 0x333333)
        return label
    }
    public var backBtn: UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }


    override func configure() {
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
    }
    
    override func addview() {
        self.addSubview(backBtn)
        self.addSubview(navititleLabel)
    }
    
    override func layout() {
        self.navititleLabel.snp.makeConstraints{
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
