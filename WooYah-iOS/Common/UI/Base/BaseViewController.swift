//
//  ViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/12.
//

import UIKit
import RxSwift
import RxKeyboard
import RxCocoa
import PinLayout
import FlexLayout
import SnapKit

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
//    private var rxKeyboard: Disposable?
    

    func layout(){}
    func addview(){}
    func configure(){}
    func setupBinding(){}
    func setupAttributes(){}
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addview()
        configure()
        setupBinding()
        setupAttributes()
        layout()
    }
}

