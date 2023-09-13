//
//  ViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/12.
//

import UIKit
import RxSwift
import RxKeyboard

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    private var rxKeyboard: Disposable?

    func layout(){}
    func addview(){}
    func configure(){}
    func setupBinding(){}
    func setupAttributes(){}
    override func viewDidLoad() {
        super.viewDidLoad()
        addview()
        configure()
        setupBinding()
        setupAttributes()
        layout()
    }
}

