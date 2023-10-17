//
//  InputPhoneNumViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/17.
//

import UIKit

class InputPhoneNumViewController: BaseViewController {
    private let viewModel:LoginViewModel!
    
    
    
    override func layout() {
        
    }
    override func addview() {
        
    }
    override func configure() {
        
    }
    
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
