//
//  WriteViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class WriteViewModel:ViewModelType {
    
    private let addedLocate = BehaviorRelay<Bool>(value: false)
    private let addedProduct = BehaviorRelay<Bool>(value: false)
    let progressBarProgress = BehaviorRelay<Float>(value: 0.1)
    var productItems: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    private var currentProductText: String = ""
    var personCount = BehaviorRelay<Int>(value: 1)
    
    func increasePersonCount() {
        let currentCount = personCount.value
        personCount.accept(currentCount + 1)
    }

    func decreasePersonCount() {
        let currentCount = personCount.value
        let newCount = max(1, currentCount - 1) // 최소값을 1로 제한
        personCount.accept(newCount)
    }
    
    func addProductItem(text: String) {
        var currentItems = productItems.value
        currentItems.append(text)
        productItems.accept(currentItems)
    }
    
    func deleteProductItem(item: String) {
        var currentItems = productItems.value
        if let index = currentItems.firstIndex(of: item) {
            currentItems.remove(at: index)
            productItems.accept(currentItems)
        }
    }
    
    private func addCurrentProductText() {
        guard !currentProductText.isEmpty else { return }
        addProductItem(text: currentProductText)
        currentProductText = ""
    }

    func transform(input: Input) -> Output {
        input.LocateBtnTap.emit(onNext: { [weak self] in
            self?.addedLocate.accept(true)
            self?.updateProgressBar()
        })
            .disposed(by: disposeBag)
        input.productText
            .subscribe(onNext: { [weak self] text in
                self?.currentProductText = text
            })
            .disposed(by: disposeBag)
        input.productAddBtnTap
            .emit(onNext: { [weak self] in
            print("추가")
            self?.addCurrentProductText()
            self?.addedProduct.accept(true)
            self?.updateProgressBar()
        })
            .disposed(by: disposeBag)
        input.personAddBtnTap
            .emit(onNext: { [weak self] in
                self?.increasePersonCount()
            })
            .disposed(by: disposeBag)

        input.personMinusBtnTap
            .emit(onNext: { [weak self] in
                self?.decreasePersonCount()
            })
            .disposed(by: disposeBag)

        return Output(productAdd: input.productText,personCount: personCount.asObservable())
    }
    
    var disposeBag: DisposeBag
    

    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
    
    struct Input {
        let LocateBtnTap: Signal<Void>
        let productText: Observable<String>
        let productAddBtnTap: Signal<Void>
        let personAddBtnTap: Signal<Void>
        let personMinusBtnTap: Signal<Void>
    }
    struct Output {
        let productAdd: Observable<String>
        let personCount: Observable<Int>
    }
    
    private func updateProgressBar() {
        // 계산된 진행 상황 값을 progressBarProgress에 할당
        var totalItemCount = addedLocate.value ? 1 : 0 // 장소가 추가되었을 때 1, 아니면 0
        totalItemCount += addedProduct.value ? 1 : 0 // 물품이 추가되었을 때 1, 아니면 0
        let progress = Float(totalItemCount) / 2.0 // 총 항목 수로 나누어 진행 상황 계산
        progressBarProgress.accept(progress)
    }
}
