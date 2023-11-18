//
//  HomeViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import UIKit

private enum Const {
  static let itemSize = CGSize(width: 300, height: 300)
  static let itemSpacing = 24.0
  
  static var insetX: CGFloat {
    (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
  }
  static var collectionViewContentInset: UIEdgeInsets {
    UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
  }
}

class HomeViewController: BaseViewController {
    private let viewModel:HomeViewModel!
    private let userinfo = UserInfo.self

    private let locateLabel = UILabel().then {
        $0.text = "xxx 근방에 올라와 있는 글들입니다!"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#484848")
        $0.sizeToFit()
    }
    private let welecomImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "welecomeImg")
        $0.backgroundColor = .clear
    }
    private let writeBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.tintColor = .white
    }
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.decelerationRate = .fast
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInset = Const.collectionViewContentInset
        layout.minimumLineSpacing = 0
        layout.minimumLineSpacing = Const.itemSpacing
        layout.itemSize = Const.itemSize
    }
    private let mainLabel = UILabel().then {
        $0.text = "우리 함께 장보러가요!"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(hexString: "#656565")
        let attributedStr = NSMutableAttributedString(string: $0.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor(hexString: "#F04343"), range: ($0.text! as NSString).range(of: "함께"))
        $0.attributedText = attributedStr
    }
    private let topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = UIColor(hexString: "#222222")
        return view
    }()
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요.\n닉네임님!"
        label.font = .pretendard(.Bold, size: 18)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.numberOfLines = 0
        return label
    }()

    override func configure() {
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.welcomeLabel.text = "안녕하세요.\n\(userinfo.shared.name ?? "유저")님!"
        self.locateLabel.text = "\(userinfo.shared.address ?? "xxx") 근방에 올라와 있는 글들입니다!"
    }
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addview() {
        self.view.addSubview(topView)
        self.topView.addSubview(welcomeLabel)
        self.view.addSubview(mainLabel)
        self.view.addSubview(mainCollectionView)
        self.topView.addSubview(writeBtn)
        self.topView.addSubview(welecomImg)
        self.view.addSubview(locateLabel)
    }
    
    override func layout() {
        self.topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(178)
        }
        self.welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        self.mainLabel.snp.makeConstraints {
            $0.top.equalTo(self.topView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
        self.mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.mainLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Const.itemSize.height + 30)
        }
        self.writeBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(25)
        }
        self.welecomImg.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(self.writeBtn.snp.leading).offset(-16)
            $0.width.equalTo(86)
            $0.height.equalTo(123)
        }
        self.locateLabel.snp.makeConstraints {
            $0.top.equalTo(self.mainCollectionView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    override func setupBinding() {
        self.writeBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let vc = WriteViewController(WriteViewModel())
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: false, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func goBtnClicked(_ sender: UIButton) {
        print("\(sender.tag)바로가기 클릭")
        self.showPopupViewController(id: 0)
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.goBtn.addTarget(self, action: #selector(self.goBtnClicked), for: .touchUpInside)
        cell.goBtn.tag = indexPath.row
        return cell
    }
    
    func scrollViewWillEndDragging(
      _ scrollView: UIScrollView,
      withVelocity velocity: CGPoint,
      targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
      let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
      let cellWidth = Const.itemSize.width + Const.itemSpacing
      let index = round(scrolledOffsetX / cellWidth)
      targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

extension HomeViewController {
    private func showPopupViewController(id: Int) {
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: false,completion: nil)
    }
}
