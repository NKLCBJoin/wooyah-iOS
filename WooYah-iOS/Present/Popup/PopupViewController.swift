//
//  PopupViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import UIKit

class PopupViewController: BaseViewController {
    
    private let viewModel: PopupViewModel
    
    private let phoneNumLabel = UILabel().then {
        $0.text = "판매자: 번호"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
        
    private let productTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor(hexString: "#E8EAF0")
        $0.layer.cornerRadius = 8
        $0.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    }
    private let locateSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
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
    
    init(viewModel: PopupViewModel, id: Int) {
        self.viewModel = viewModel
        viewModel.updateInfo(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.isOpaque = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        let contentTapGesture = UITapGestureRecognizer(target: self, action: nil)
        contentView.addGestureRecognizer(contentTapGesture)
        productTableView.delegate = self
    }
    
    override func addview() {
        self.view.addSubview(contentView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(productTableView)
        self.contentView.addSubview(phoneNumLabel)
        self.contentView.addSubview(locateSV)
        self.locateSV.addArrangedSubview(locateIcon)
        self.locateSV.addArrangedSubview(locateLabel)
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
        self.productTableView.snp.makeConstraints {
            $0.top.equalTo(locateSV.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(300)
        }
        self.phoneNumLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(55)
        }
    }
    
    override func setupBinding() {

        viewModel.detail
            .bind(onNext: { [weak self] info in
                self?.locateLabel.text = "장보는 장소: \(info.result?.shoppingLocation ?? "")"
                self?.nameLabel.text = info.result?.nickname
                self?.phoneNumLabel.text = "판매자:" + info.result!.ownerPhoneNumber
            })
            .disposed(by: disposeBag)
        
        viewModel.productDetail
            .bind(to: productTableView.rx.items(cellIdentifier: ProductTableViewCell.identifier, cellType: ProductTableViewCell.self)) { index, item, cell in
                cell.configureCell(item,buy: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func handleTap() {
        self.dismiss(animated: false, completion: nil)
    }
}
extension PopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}
