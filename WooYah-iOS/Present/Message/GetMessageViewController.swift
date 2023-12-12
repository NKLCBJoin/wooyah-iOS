//
//  GetMessageViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/12/03.
//

import UIKit

class GetMessageViewController: BaseViewController {
    
    private let rejectLabel = UILabel().then {
        $0.text = "아쉽게도 상대가 요청을 거절했습니다."
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
    private let closeBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#65607")
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.font = .pretendard(.Bold, size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    private let rejectImg = UIImageView().then {
        $0.image = UIImage(named: "rejectImg")
        $0.contentMode = .scaleAspectFit
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
        self.contentView.addSubview(locateSV)
        self.locateSV.addArrangedSubview(locateIcon)
        self.locateSV.addArrangedSubview(locateLabel)
        self.contentView.addSubview(rejectImg)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(rejectLabel)
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
        self.rejectImg.snp.makeConstraints {
            $0.top.equalTo(locateSV.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(300)
        }
        self.rejectLabel.snp.makeConstraints {
            $0.top.equalTo(rejectImg.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
        }
        self.closeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(52)
        }
    }
    
    override func setupBinding() {
        
    }
    
    @objc private func handleTap() {
        self.dismiss(animated: false, completion: nil)
    }
}
