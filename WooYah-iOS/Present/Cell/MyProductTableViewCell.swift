//
//  MyProductTableViewCell.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import UIKit
import RxSwift

class MyProductTableViewCell: UITableViewCell {
    static let identifier = "MyProductTableViewCell"
    var disposeBag = DisposeBag()
    
    private let locateLabel = UILabel().then {
        $0.text = "asd"
        $0.font = .pretendard(.SemiBold, size: 14)
        $0.textColor = UIColor(hexString: "#111111")
        $0.sizeToFit()
    }
    private let personCountLabel = UILabel().then {
        $0.text = "asd"
        $0.font = .pretendard(.SemiBold, size: 14)
        $0.textColor = UIColor(hexString: "#111111")
        $0.sizeToFit()
    }
    
    
    private func addsubview(){
        self.addSubview(personCountLabel)
        self.addSubview(locateLabel)
    }
    
    private func configure(){
        self.backgroundColor = .white
    }
    
    private func layout(){
        locateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        personCountLabel.snp.makeConstraints {
            $0.top.equalTo(locateLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    func configureCell(_ item: ProductInfoDTO) {
        locateLabel.text = "장소: \(item.shoppingLocation)"
        personCountLabel.text = "모집인원: \(item.participantNumber)명"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
        self.addsubview()
        self.layout()
        // Other setup code
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
