//
//  DropDownTableViewCell.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/11/21.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    static let identifier = "DropDownTableViewCell"
    public var cartNameLabel = UILabel().then{
        $0.text = "asd"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#111111")
    }
    private func layout(){
        self.cartNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
        }
    }
    private func addsubview(){
        self.addSubview(cartNameLabel)
    }
    private func configure(){
        self.backgroundColor = .white
    }
    
    func configureCell(_ item:CartListDTO) {
        cartNameLabel.text = String(item.cartId)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addsubview()
        self.layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
