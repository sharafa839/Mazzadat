//
//  LoginViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 01/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class LoginViewModel:AuthNetworkingProtocol {
    var disposeBag = DisposeBag()

    var auth: AuthNetworkingProtocol

    var email = BehaviorRelay<String>(value: "")
    
    var password = BehaviorRelay<String>(value: "")
      
    var showLoading = BehaviorRelay<Bool>(value:false)
    
    var onError = PublishSubject<String>()
    
    var onSuccess = PublishSubject<Void>()

    var isPhoneEmpty : Observable<Bool> {
      return email.asObservable().map { (phoneIsValid)->Bool in
          return (phoneIsValid.isValidEmail)
      }
    }
    
    var isPasswordValid : Observable<Bool> {
      return password.asObservable().map { (isPasswordPropriety) in
        return isPasswordPropriety.count > 5
      }
    }
    
    var isContinueButtonEnabled:Observable<Bool>{
   
        return Observable.combineLatest(isPhoneEmpty,isPasswordValid){(phone,pass) in
            return (phone  && pass )
        }
    }
    
    //MARK: - Initializers
    init(authRepo:AuthRepo = AuthRepo()) {
      auth = authRepo
    }
    //MARK: - Methods
    
     func loginWithPhoneAndPassword() {
       showLoading.accept(true)
         login(email: email.value, password: password.value) { [weak self] result in
             self?.showLoading.accept(false)
             switch result {
             case .failure(let error):
                 self?.onError.onNext(error.localizedDescription)
             case .success(let response):
                 guard let loginPayload = response.response?.data else {return}
                 HelperK.setUserData(loginPayLoad: loginPayload)
                 CoreData.shared.personalSubscription = loginPayload.subscriptions

                 self?.onSuccess.onNext(())
             }
         }
        
      
     }
  }
