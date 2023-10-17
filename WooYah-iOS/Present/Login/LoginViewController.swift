//
//  LoginViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import UIKit
import RxSwift
import KakaoSDKCommon
import RxKakaoSDKCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser
import AuthenticationServices
import NaverThirdPartyLogin

final class LoginViewController: BaseViewController {
    
    private let viewModel:LoginViewModel!
    private let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 함께 신선한 야채를 구매해요."
        label.font = .pretendard(.Regular, size: 18)
        label.textColor = UIColor(hexString: "#666670")
        let attributedText = NSMutableAttributedString(string: "우리 함께 신선한 야채를 구매해요.")
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: (label.text! as NSString).range(of: "우"))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: (label.text! as NSString).range(of: "야"))
        attributedText.addAttribute(.font, value:UIFont.pretendard(.SemiBold, size: 18), range: (label.text! as NSString).range(of: "우"))
        attributedText.addAttribute(.font, value:UIFont.pretendard(.SemiBold, size: 18), range: (label.text! as NSString).range(of: "야"))
        label.attributedText = attributedText
        return label
    }()
    
    private let logo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "logo")
        img.backgroundColor = .clear
        img.layer.masksToBounds = true
        return img
    }()
    
    private let kakaoBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "KaKaoLogin"), for: .normal)
        return btn
    }()
    private let naverBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "NaverLogin"), for: .normal)
        return btn
    }()
    private let appleBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "appleLogin"), for: .normal)
        return btn
    }()
    
    private let flexContainer = UIView()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "소셜 계정을 통해 \n 로그인 또는 회원가입을 진행해 주세요."
        label.font = .pretendard(.Regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#8B8B91")
        return label
    }()
    
    override func configure() {
        flexContainer.flex.direction(.row).define{
            $0.addItem(kakaoBtn).width(49).height(49)
            $0.addItem(naverBtn).width(49).height(49).marginStart(20)
            $0.addItem(appleBtn).width(49).height(49).marginStart(20)
        }
    }
    override func addview() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(logo)
        self.view.addSubview(flexContainer)
        self.view.addSubview(loginLabel)
    }
    
    override func layout() {
        self.titleLabel.pin.top(self.view.pin.safeArea).hCenter().sizeToFit().margin(200)
        self.logo.pin.topCenter(to: self.titleLabel.anchor.bottomCenter).margin(90).width(52).height(90)
        self.flexContainer.pin.topCenter(to: self.logo.anchor.bottomCenter).margin(120).width(184)
        self.flexContainer.flex.layout(mode: .adjustHeight)
        self.loginLabel.pin.topCenter(to: self.flexContainer.anchor.bottomCenter).margin(32).sizeToFit()
    }
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupBinding() {
        self.appleBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.signInWithApple()
            })
            .disposed(by: disposeBag)
        self.kakaoBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.signInWithKakao()
            })
            .disposed(by: disposeBag)

        self.naverBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.naverLoginInstance?.requestThirdPartyLogin()
            })
            .disposed(by: disposeBag)
    }
}

