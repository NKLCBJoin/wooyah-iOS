//
//  WriteViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import UIKit

class WriteViewController: BaseViewController {

    private let viewModel : WriteViewModel!
    private let navibar : CustomNaviBar = CustomNaviBar(frame: .zero)
    private let progressBar = UIProgressView().then {
        $0.trackTintColor = UIColor(hexString: "#C4C4C4")
        $0.progress = 0.1
        $0.progressTintColor = UIColor(hexString: "#333333")
    }
    private let scrollView = UIScrollView()
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let titleLabel = UILabel().then {
        $0.text = "장보기 정보를\n입력해주세요."
        $0.font = .pretendard(.Bold, size: 24)
        $0.textColor = UIColor(hexString: "#000000")
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    private let locateLabel = UILabel().then {
        $0.text = "장소"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#333333")
        $0.sizeToFit()
    }
    private let inputLocateTextField = UITextField().then {
        $0.placeholder = " 장보기 장소를 입력해주세요."
        $0.backgroundColor = UIColor(hexString: "#FAFAFD")
        $0.layer.cornerRadius = 20
    }
    private let productLabel = UILabel().then {
        $0.text = "물품"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#333333")
        $0.sizeToFit()
    }
    private let inputproductTextField = UITextField().then {
        $0.placeholder = " 물품을 추가해주세요."
        $0.backgroundColor = UIColor(hexString: "#FAFAFD")
        $0.layer.cornerRadius = 20
    }
    private let productAddBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#333333")
        $0.setTitle("추가", for: .normal)
        $0.titleLabel?.font = .pretendard(.Regular, size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    private let productTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor(hexString: "#F8F8F8")
        $0.layer.cornerRadius = 8
    }
    private let personLabel = UILabel().then {
        $0.text = "함께할 인원수"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#333333")
        $0.sizeToFit()
    }
    private let personflexContainer = UIView()
    private let personCountLabel = UILabel().then {
        $0.text = "1명"
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#999999")
        $0.sizeToFit()
    }
    private let plusBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = UIColor(hexString: "#333333")
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.backgroundColor = .clear
    }
    private let minusBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.tintColor = UIColor(hexString: "#333333")
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.backgroundColor = .clear
    }
    private let completeBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#CCCCCC")
        $0.setTitle("함께할사람 구하기", for: .normal)
        $0.titleLabel?.font = .pretendard(.Regular, size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    
    override func layout() {
        self.navibar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(self.navibar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.progressBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        self.contentView.snp.makeConstraints {
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(692)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(26)
        }
        self.locateLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(26)
        }
        self.inputLocateTextField.snp.makeConstraints {
            $0.top.equalTo(self.locateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(52)
        }
        self.productLabel.snp.makeConstraints {
            $0.top.equalTo(self.inputLocateTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(26)
        }
        self.inputproductTextField.snp.makeConstraints {
            $0.top.equalTo(self.productLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalTo(self.productAddBtn.snp.leading).offset(-18)
            $0.height.equalTo(52)
        }
        self.productAddBtn.snp.makeConstraints {
            $0.top.equalTo(self.inputLocateTextField.snp.bottom).offset(59)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
            $0.width.equalTo(66)
        }
        self.productTableView.snp.makeConstraints {
            $0.top.equalTo(self.inputproductTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(188)
        }
        self.personLabel.snp.makeConstraints {
            $0.top.equalTo(self.productTableView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(26)
        }
        self.personflexContainer.flex.direction(.row).define{
            $0.addItem(personCountLabel).height(25)
            $0.addItem(minusBtn).width(25).height(25).marginStart(20)
            $0.addItem(plusBtn).width(25).height(25).marginStart(20)
        }
        self.personflexContainer.snp.makeConstraints {
            $0.top.equalTo(self.personLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(26)
            $0.height.equalTo(50)
        }
        self.personflexContainer.flex.layout(mode: .adjustWidth)
        self.completeBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }

        
    }
    override func configure() {
        self.navibar.navititleLabel.text = "장보기 작성"
        self.navibar.backBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.navibar.delegate = self
    }
    override func addview() {
        self.view.addSubview(navibar)
        self.view.addSubview(progressBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(locateLabel)
        self.contentView.addSubview(inputLocateTextField)
        self.contentView.addSubview(productLabel)
        self.contentView.addSubview(inputproductTextField)
        self.contentView.addSubview(productAddBtn)
        self.contentView.addSubview(productTableView)
        self.contentView.addSubview(personLabel)
        self.contentView.addSubview(personflexContainer)
        self.contentView.addSubview(completeBtn)
    }
    init(_ viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WriteViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
}
