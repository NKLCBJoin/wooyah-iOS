//
//  InputPhoneNumViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/17.
//

import UIKit

class InputPhoneNumViewController: BaseViewController, CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    private let viewModel:LoginViewModel!
    
    private let naviBar:CustomNaviBar = CustomNaviBar(frame: .zero)
    
    
    override func layout() {
        print("qweqwe")
        self.naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    }
    
    override func addview() {
        self.view.addSubview(naviBar)
    }
    
    override func configure() {
        self.naviBar.delegate = self // CustomNaviBar의 델리게이트를 설정

    }
    
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
