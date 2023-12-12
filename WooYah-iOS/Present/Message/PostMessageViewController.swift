//
//  PostMessageViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/03.
//

import UIKit

class PostMessageViewController: BaseViewController {
    
    private let phoneNum = UILabel().then {
        $0.text = "연락처: 010-xxxx-xxxx"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
    private let rejectBtn = UIButton().then {
        $0.titleLabel?.font = .pretendard(.Regular, size: 14)
        $0.backgroundColor = UIColor(hexString: "#FF7D7D")
        $0.setTitle("거절", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    private let acceptBtn = UIButton().then {
        $0.titleLabel?.font = .pretendard(.Regular, size: 14)
        $0.backgroundColor = UIColor(hexString: "#656070")
        $0.setTitle("수락", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    private let productTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor(hexString: "#E8EAF0")
        $0.layer.cornerRadius = 8
    }
    private let locateSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    private let locateInfoLabel = UILabel().then {
        $0.text = "동부 이촌동이마트"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
    private let locateLabel = UILabel().then {
        $0.text = "장보는 장소"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
    private let locateIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "locat")
        $0.backgroundColor = .clear
    }
    private let nameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .pretendard(.Bold, size: 16)
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
        self.contentView.addSubview(locateInfoLabel)
        self.contentView.addSubview(productTableView)
        self.contentView.addSubview(locateSV)
        self.locateSV.addArrangedSubview(locateIcon)
        self.locateSV.addArrangedSubview(locateLabel)
        self.contentView.addSubview(phoneNum)
        self.contentView.addSubview(acceptBtn)
        self.contentView.addSubview(rejectBtn)
    }
    
    override func layout() {
        self.contentView.snp.makeConstraints{
            $0.height.equalTo(485)
            $0.width.equalTo(327)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(20)
        }
        self.locateSV.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(20)
        }
        self.locateInfoLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(locateSV.snp.trailing).offset(20)
        }
        self.productTableView.snp.makeConstraints {
            $0.top.equalTo(locateSV.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(300)
        }
        self.phoneNum.snp.makeConstraints {
            $0.top.equalTo(productTableView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)

        }
        self.rejectBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(40)
            $0.width.equalTo(111)
            $0.height.equalTo(48)
        }
        self.acceptBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(40)
            $0.width.equalTo(111)
            $0.height.equalTo(48)
        }
    }
    
    override func setupBinding() {
        
    }
    
    @objc private func handleTap() {
        self.dismiss(animated: false, completion: nil)
    }
}
