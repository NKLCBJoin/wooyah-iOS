//
//  InputPhoneNumViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/17.
//

import UIKit

enum TextRange {
    case over
    case under
    case normal
}
class InputPhoneNumViewController: BaseViewController, CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private let viewModel: InputPhoneViewModel!
    
    private let naviBar:CustomNaviBar = CustomNaviBar(frame: .zero)
    
    private var phoneLable = UILabel().then {
        $0.text = ""
        $0.font = .pretendard(.Regular, size: 14)
    }
    private var phoneTextField = UITextField().then {
        $0.placeholder = "입력)010-1234-5678"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음 ", for: .normal)
        $0.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#DDDDE3")
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    override func layout() {
        self.naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.phoneTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(self.naviBar.snp.bottom).offset(30)
        }
        self.nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }
        self.phoneLable.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    override func addview() {
        self.view.addSubview(naviBar)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(nextBtn)
        self.view.addSubview(phoneLable)
    }
    
    override func configure() {
        self.naviBar.delegate = self // CustomNaviBar의 델리게이트를 설정
        self.naviBar.navititleLabel.text = "휴대폰 번호를 입력해주세요."
    }
    
    override func setupBinding() {
        
        let input = InputPhoneViewModel.Input(phoneNumberText: self.phoneTextField.rx.text.orEmpty.asObservable(), nextBtnTap: self.nextBtn.rx.tap.asSignal())
        let output = self.viewModel.transform(input: input)

        self.phoneTextField.rx.text.orEmpty.map(checkPhoneNum(_:)).subscribe(onNext: { text in
            switch text {
            case .over:
                self.phoneTextField.layer.borderColor = UIColor(hexString: "#1F4EF6").cgColor
                self.phoneLable.text = "올바른 휴대폰 번호입니다."
                self.phoneLable.textColor = UIColor(hexString: "#1F4EF6")
                self.nextBtn.setNextButtonState(state: .enabled)
            case .under:
                self.phoneTextField.layer.borderColor = UIColor(hexString: "#FF7B7B").cgColor
                self.phoneLable.text = "잘못된 형식의 번호입니다."
                self.phoneLable.textColor = UIColor(hexString: "#FF7B7B")
                self.nextBtn.isEnabled = false
                self.nextBtn.setNextButtonState(state: .disabled)
            case .normal:
                self.phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
                self.phoneLable.text = ""
                self.nextBtn.isEnabled = false
                self.nextBtn.setNextButtonState(state: .disabled)
            }
        })
        .disposed(by: disposeBag)
        
        output.isValidPhone
            .asDriver(onErrorJustReturn: false)
            .drive(self.nextBtn.rx.isEnabled)
            .disposed(by: disposeBag)
//        output.registerPublisher.bind(onNext: { [weak self] res in
////            guard let self else { return }
////            switch res {
////            case .success:
////                print("성공")
////            case .failure(let error):
////                print("실패")
//            }
//        }).disposed(by: disposeBag)

        output.nextBtnTap.emit(onNext: { [weak self] in
            self?.navigationController?.pushViewController(TabBarController(), animated: true)
        })
        .disposed(by: disposeBag)

    }

    private func checkPhoneNum(_ text: String) -> TextRange {
        if text.count >= 11 {
            let index = text.index(text.startIndex, offsetBy: 11)
            self.phoneTextField.text = String(text[..<index])
            
            return .over
        }
        if text.count < 1 {
            return .normal
        }
        return .under
    }
    
    init(_ viewModel: InputPhoneViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

