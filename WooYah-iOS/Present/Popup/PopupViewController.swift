//
//  PopupViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import UIKit

class PopupViewController: BaseViewController {
    
    private let postBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#65607")
        $0.setTitle("함께 장보기 요청", for: .normal)
        $0.titleLabel?.font = .pretendard(.Bold, size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    private let productTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor(hexString: "#E8EAF0")
        $0.layer.cornerRadius = 8
    }
    private let locateInfoLabel = UILabel().then {
        $0.text = "동부 이촌동이마트"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(hexString: "#656565")
        $0.sizeToFit()
    }
    private let locateLabel = UILabel().then {
        $0.text = "장보는 장소"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(hexString: "#656565")
        $0.sizeToFit()
    }
    private let locateIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "locat")
        $0.backgroundColor = .clear
    }
    private let nameLabel = UILabel().then {
        $0.text = "우리 함께 장보러가요!"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(hexString: "#656565")
        $0.sizeToFit()
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    override func configure() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.isOpaque = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        let contentTapGesture = UITapGestureRecognizer(target: self, action: nil)
        contentView.addGestureRecognizer(contentTapGesture)
    }
    
    override func addview() {
        self.view.addSubview(contentView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(locateIcon)
        self.contentView.addSubview(locateLabel)
        self.contentView.addSubview(locateInfoLabel)
        self.contentView.addSubview(productTableView)
        self.contentView.addSubview(postBtn)
    }
    
    override func layout() {
        self.contentView.snp.makeConstraints{
            $0.height.equalTo(419)
            $0.width.equalTo(327)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    @objc private func handleTap() {
        self.dismiss(animated: false, completion: nil)
    }
}
