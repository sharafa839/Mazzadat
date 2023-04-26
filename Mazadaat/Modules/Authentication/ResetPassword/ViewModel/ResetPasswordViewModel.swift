//
//  ResetPasswordView.swift
//  Mazadaat
//
//  Created by Sharaf on 16/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class ResetPasswordViewModel:AuthRepo {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var password = BehaviorRelay<String>(value: "")
    var confirmPassword = BehaviorRelay<String>(value: "")
    var onSuccess = PublishSubject<Void>()
    var isPasswordValid : Observable<Bool> {
      return password.asObservable().map { (isPasswordPropriety) in
        return isPasswordPropriety.count > 5
      }
    }
    
    var isConfirmPasswordValid : Observable<Bool> {
      return confirmPassword.asObservable().map { (isPasswordPropriety) in
        return isPasswordPropriety.count > 5
      }
    }
    
    
    var isContinueButtonEnabled:Observable<Bool>{
   
        return Observable.combineLatest(isConfirmPasswordValid,isPasswordValid){(confirm,pass) in
            return (confirm  && pass )
        }
    }
    var phoneNumber:String
    
    init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
    }
    
    func resetPassword() {
        guard password.value == confirmPassword.value else {
            onError.onNext("doesn't matching")
            return
        }
        
        resetPassword(phone: phoneNumber, password: password.value, confirmPassword: confirmPassword.value) { [weak self] value in
            switch value {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                self?.onSuccess.onNext(())
            }
        }
        
        
    }
    
    
    
}

