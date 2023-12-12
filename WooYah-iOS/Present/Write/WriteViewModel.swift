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
    var productItems =  BehaviorRelay<[String]>(value: [])
    private var currentProductText = ""
    var personCount = BehaviorRelay<Int>(value: 1)
    let locate = BehaviorRelay<String>(value: "")
    private let usecase: ProductUseCaseProtocol
    private let disposebag = DisposeBag()
    let lat = BehaviorRelay<Double>(value: 0.0)
    let lng = BehaviorRelay<Double>(value: 0.0)

    var disposeBag = DisposeBag()

    
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
        
        input.completeBtnTap
            .emit(onNext: { [weak self] in
                let writeProduct = WriteProductDTO(
                    location: self?.locate.value ?? "", // Assuming locate is a string
                    participantNumber: self?.personCount.value ?? 2,
                    latitude: self?.lat.value ?? 0.0, // Assuming lat is a double
                    longitude: self?.lng.value ?? 0.0, // Assuming lng is a double
                    products: self?.productItems.value ?? [""]
                )
                print(writeProduct)
                self?.usecase.WriteCart(with: writeProduct)
                    .subscribe { event in
                         switch event {
                         case .success(let response):
                             // Handle success
                             print("Success: \(response)")
                         case .failure(let error):
                             // Handle error
                             print("Error: \(error)")
                         }
                     }
                    .disposed(by:self!.disposeBag)
            })
            .disposed(by: disposeBag)

        return Output(productAdd: input.productText,personCount: personCount.asObservable())
    }
        
    init(usecase: ProductUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        let LocateBtnTap: Signal<Void>
        let productText: Observable<String>
        let productAddBtnTap: Signal<Void>
        let personAddBtnTap: Signal<Void>
        let personMinusBtnTap: Signal<Void>
        let completeBtnTap: Signal<Void>
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
