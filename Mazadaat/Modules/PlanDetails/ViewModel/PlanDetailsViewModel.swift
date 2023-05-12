//
//  PlanDetailsViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class PlanDetailsViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var methods:[PaymentMethodCases] = [.bankTransfer,.cash]
    var onSuccess = PublishSubject<Void>()
    var subscription:Subscription
    var paymentMethodId = 2
    var placeId:String
    
    init(subscription:Subscription) {
        self.subscription = subscription
        self.placeId = ""
    }
    
    convenience init(placeId:String) {
        self.init(subscription: Subscription())
        self.placeId = placeId
       
    }
    
    func uploadBankTransfer(image:MultiPartItem?,subscriptionId:String,paymentMethod:String) {
        onLoading.accept(true)
        subscribe(image: image, subscription_id: subscriptionId, paymentMethod: paymentMethod) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccess.onNext(())
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func payEntryFees(image:MultiPartItem?,placeId:String,paymentMethod:String) {
        onLoading.accept(true)
        payEntryFee(placeID: placeId, payment_method_id: paymentMethod, image: image) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccess.onNext(())
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}
