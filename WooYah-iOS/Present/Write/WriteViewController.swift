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
    
    override func layout() {
        self.navibar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
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
