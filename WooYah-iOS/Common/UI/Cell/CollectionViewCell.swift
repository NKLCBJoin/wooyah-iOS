//
//  CollectionViewCell.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    var carLabel = UILabel().then {
        $0.text = "마늘(2개) \n계란 1판(15알씩)\n베이글(2쪽씩)"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#484848")
        $0.numberOfLines = 0
        $0.baselineAdjustment = .alignCenters
        $0.backgroundColor = .clear
    }
    
    private let myView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = false
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.shadowRadius = 5 //반경
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.clear.cgColor

    }
    var nameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .pretendard(.Bold, size: 24)
        $0.textColor = UIColor(hexString: "#333333")
    }
    
    private let Img = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "locat")
    }
    
    var locateLabel = UILabel().then {
        $0.text = "장보는 장소"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(hexString: "#333333")

    }
    let goBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#333333")
        $0.setTitle("바로가기", for: .normal)
        $0.titleLabel?.font = .pretendard(.Bold, size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func addView() {
        self.addSubview(myView)
        self.addSubview(goBtn)
        self.addSubview(locateLabel)
        self.addSubview(Img)
        self.addSubview(nameLabel)
        self.addSubview(carLabel)
    }
    
    func layout() {
        self.myView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        self.goBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        self.locateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-16)
        }
        self.Img.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalTo(self.locateLabel.snp.leading).offset(-8)
        }
        self.carLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(180)
        }
    }
    @available(*, unavailable)
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
     
     override init(frame: CGRect) {
       super.init(frame: frame)
         self.addView()
         self.layout()
     }
}
