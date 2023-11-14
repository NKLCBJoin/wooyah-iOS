//
//  WriteViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WriteViewController: BaseViewController, UIScrollViewDelegate {

    private let viewModel : WriteViewModel!
    private let navibar : CustomNaviBar = CustomNaviBar(frame: .zero)
    private var progressBarTimer: Observable<Float>?
    private var isEnabledObservable = BehaviorRelay<Bool>(value: false)

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
    private let inputLocateBtn = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FAFAFD")
        $0.setTitle(" 장소를 입력해주세요.", for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = .pretendard(.Regular, size: 15)
        $0.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
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
    private let CountBtnSV = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 10
    }
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
        self.inputLocateBtn.snp.makeConstraints {
            $0.top.equalTo(self.locateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(52)
        }
        self.productLabel.snp.makeConstraints {
            $0.top.equalTo(self.inputLocateBtn.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(26)
        }
        self.inputproductTextField.snp.makeConstraints {
            $0.top.equalTo(self.productLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalTo(self.productAddBtn.snp.leading).offset(-18)
            $0.height.equalTo(52)
        }
        self.productAddBtn.snp.makeConstraints {
            $0.top.equalTo(self.inputLocateBtn.snp.bottom).offset(59)
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
        self.personCountLabel.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(26)
        }
        self.CountBtnSV.snp.makeConstraints {
            $0.top.equalTo(personLabel.snp.bottom).offset(5)
            $0.leading.equalTo(self.personCountLabel.snp.trailing).offset(10)
        }

        self.completeBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }
    }
    
    override func configure() {
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        self.navibar.navititleLabel.text = "장보기 작성"
        self.navibar.backBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.navibar.delegate = self
        self.productTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addview() {
        self.view.addSubview(navibar)
        self.view.addSubview(progressBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(locateLabel)
        self.contentView.addSubview(inputLocateBtn)
        self.contentView.addSubview(productLabel)
        self.contentView.addSubview(inputproductTextField)
        self.contentView.addSubview(productAddBtn)
        self.contentView.addSubview(productTableView)
        self.contentView.addSubview(personLabel)
        self.contentView.addSubview(personCountLabel)
        self.contentView.addSubview(CountBtnSV)
        self.CountBtnSV.addArrangedSubview(plusBtn)
        self.CountBtnSV.addArrangedSubview(minusBtn)
        self.contentView.addSubview(completeBtn)
        
    }
    
    init(_ viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupBinding() {
        let input = WriteViewModel.Input(LocateBtnTap: self.inputLocateBtn.rx.tap.asSignal(),
                                         productText: self.inputproductTextField.rx.text.orEmpty.asObservable(),
                                         productAddBtnTap: self.productAddBtn.rx.tap.asSignal(),
                                         personAddBtnTap: self.plusBtn.rx.tap.asSignal(),
                                         personMinusBtnTap: self.minusBtn.rx.tap.asSignal())
        let output = self.viewModel.transform(input: input)
        
        output.personCount
            .map { count in
                return "\(count)명"
            }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: personCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.inputLocateBtn.rx.tap
            .asDriver()
            .flatMap { [weak self] _ -> Driver<String> in
                let vc = SearchAddressViewController()
                self?.present(vc, animated: true, completion: nil)
                return vc.locateSubject.asDriver(onErrorJustReturn: "")
            }
            .drive(inputLocateBtn.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        self.productAddBtn.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.inputproductTextField.text = ""
        })
        .disposed(by: disposeBag)
        
        viewModel.productItems
            .asObservable()
            .bind(to: productTableView.rx.items(cellIdentifier: "ProductTableViewCell",cellType: ProductTableViewCell.self)) { index, item, cell in
                cell.selectionStyle = .none
                cell.ItemLabel.text = item
            }
            .disposed(by: disposeBag)
        
        productTableView.rx.modelSelected(String.self)
                   .bind { [weak self] item in
                       self?.viewModel.deleteProductItem(item: item)
                }
                .disposed(by: disposeBag)

        self.completeBtn.rx.tap
            .withLatestFrom(isEnabledObservable.asObservable())
            .filter { isEnabled in
                return isEnabled
            }
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)

        viewModel.progressBarProgress
            .bind(to: progressBar.rx.progress)
            .disposed(by: disposeBag)
        
        viewModel.progressBarProgress
            .subscribe(onNext: { progress in
                if progress == 1 {
                    self.completeBtn.setNextButtonState(state: .enabled)
                    self.isEnabledObservable.accept(true)
                }
        })
        .disposed(by: disposeBag)
        
        progressBarTimer?
              .subscribe()
              .disposed(by: disposeBag)
    }
    
    // 프로그레스 바 업데이트 함수
    private func updateProgressBar(with progress: Float) {
        progressBar.progress = progress

        if progress == 1 {
            completeBtn.setNextButtonState(state: .enabled)
        }
    }

    private func selectLocate() -> Observable<String> {
        let vc = SearchAddressViewController()
         self.present(vc,animated: true,completion: nil)
        return vc.locateSubject
    }
}
extension WriteViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
}
