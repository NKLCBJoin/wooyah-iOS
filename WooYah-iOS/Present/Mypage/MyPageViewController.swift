//
//  MyPageViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MyPageViewController: BaseViewController {
    
    private let viewModel: MyPageViewModel
    private let naviBar:CustomNaviBar = CustomNaviBar(frame: .zero)
    private let myProductTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .clear
        $0.allowsSelection = true
        $0.separatorStyle = .singleLine
        $0.bounces = true
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.register(MyProductTableViewCell.self, forCellReuseIdentifier: MyProductTableViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
    }
    private let titleLabel = UILabel().then {
        $0.text = "내가 올린공고"
        $0.font = .pretendard(.SemiBold, size: 20)
        $0.textColor = UIColor(hexString: "#111111")
        $0.sizeToFit()
    }
    private let welecomImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "hi")
        $0.backgroundColor = .clear
    }
    private let nameLabel = UILabel().then {
        $0.text = "xx님, 안녕하세요."
        $0.font = .pretendard(.SemiBold, size: 20)
        $0.textColor = UIColor(hexString: "#666666")
        $0.sizeToFit()
    }
    
    init(_ viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateDummy()
    }
    
    override func configure() {
        naviBar.backBtn.isHidden = true
        naviBar.navititleLabel.text = "마이페이지"
        self.nameLabel.text = UserInfo.shared.name
    }
    
    override func addview() {
        self.view.addSubview(naviBar)
        self.view.addSubview(welecomImg)
        self.view.addSubview(nameLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(myProductTableView)
    }
    
    override func layout() {
        self.naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.welecomImg.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(120)
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(welecomImg.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        self.myProductTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(400)
        }
    }
    
    override func setupBinding() {
        
        viewModel.dummyList.bind(to: self.myProductTableView.rx.items(cellIdentifier: MyProductTableViewCell.identifier, cellType: MyProductTableViewCell.self))
        {   index, item, cell in
            print(item)
            cell.configureCell(item)
        }
        .disposed(by: disposeBag)
        
        myProductTableView.rx.itemDeleted
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                // 실제 데이터 삭제 작업 수행 (ViewModel에서 처리)
                self.viewModel.deleteItem(at: indexPath)
            })
            .disposed(by: disposeBag)
        
        myProductTableView.rx.modelSelected(MyPageDummy.self)
            .bind(onNext: { [weak self] cell in
                self?.pushDetailCart(id: cell.cartId)
            })
            .disposed(by: disposeBag)
    }
}
extension MyPageViewController {
    private func pushDetailCart(id:Int) {
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: false,completion: nil)
    }
}
