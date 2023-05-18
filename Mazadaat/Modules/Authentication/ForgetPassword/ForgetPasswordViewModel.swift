//
//  ForgetPasswordViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 18/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class ForgetPasswordViewModel:AuthNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
   let onSuccess = PublishSubject<String>()
    func forgetPassword(phoneNumber:String) {
        onLoading.accept(true)
        forgetPassword(phoneNumber: phoneNumber) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccess.onNext(phoneNumber)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    
}

