//
//  ProductTableViewCell.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/05.
//

import UIKit
import RxCocoa
import RxSwift

class ProductTableViewCell: UITableViewCell {
    static let identifier = "ProductTableViewCell"
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    

    var ItemLabel: UILabel = {
        let label = UILabel()
        label.text = "물품"
        label.font = .pretendard(.Regular, size: 16)
        label.textColor = UIColor(hexString: "#484848")
        return label
    }()
    
    let DeleteBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor(hexString: "#333333")
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.backgroundColor = .clear
    }
    
    private func layout() {
        self.ItemLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.DeleteBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.ItemLabel.snp.trailing).offset(5)
            $0.width.height.equalTo(25)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(ItemLabel)
        self.addSubview(DeleteBtn)
        self.layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
