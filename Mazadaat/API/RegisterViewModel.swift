//
//  RegisterViewModel.swift
//  Dana
//
//  Created by Shgardi on 28/05/2022.
//

import Foundation
import RxRelay
import RxSwift

class RegisterViewModel:AuthNetworkingProtocol {
 
  

  //MARK: - Properties
  var disposeBag = DisposeBag()

  var auth: AuthNetworkingProtocol

  var phone = BehaviorRelay<String>(value: "")
  
  var password = BehaviorRelay<String>(value: "")
    
  var showLoading = BehaviorRelay<Bool>(value:false)
  
  var onError = PublishSubject<String>()
  
  var onSuccess = PublishSubject<Void>()

  var name = BehaviorRelay<String>(value: "")
  
  var email = BehaviorRelay<String>(value: "")
  
  var state = BehaviorRelay<String>(value: "")
  
  var city = BehaviorRelay<String>(value: "")
  
  var confirmPassword = BehaviorRelay<String>(value: "")
  
  
  var isPhoneEmpty : Observable<Bool> {
    return phone.asObservable().map { (phoneIsValid)->Bool in
      return !(phoneIsValid.isEmpty)
    }
  }
  
  var isPasswordValid : Observable<Bool> {
    return password.asObservable().map { (isPasswordPropriety) in
      return isPasswordPropriety.count > 5
    }
  }
  
  var isEmailValid : Observable<Bool> {
    return email.asObservable().map { (emailIsValid)->Bool in
      return (emailIsValid.isValidEmail)
    }
  }
  
  var isNameValid : Observable<Bool> {
    return name.asObservable().map { (isNamePropriety) in
      return isNamePropriety.count >= 3
    }
  }
  
  var isCityValid : Observable<Bool> {
    return city.asObservable().map { (cityIsValid)->Bool in
      return !(cityIsValid.isEmpty)
    }
  }
  
  var isConfirmPasswordValid : Observable<Bool> {
    return confirmPassword.asObservable().map { (isPasswordPropriety) in
      return isPasswordPropriety.count > 5
    }
  }
  
  var isStateEmpty : Observable<Bool> {
    return state.asObservable().map { (stateIsValid)->Bool in
      return !(stateIsValid.isEmpty)
    }
  }

  
  var isContinueButtonEnabled: Observable<Bool> {
    return Observable.combineLatest(isPhoneEmpty,isPasswordValid,isNameValid,isConfirmPasswordValid,isEmailValid){(phone,pass,name,confirm,email) in
        return (phone  && pass && name && confirm && email )
    }
  }

  //MARK: - Initializers
  
  init(authRepo:AuthRepo = AuthRepo()){
    self.auth = authRepo
  }
  //MARK: - Methods
  func signUp() {
    showLoading.accept(true)
    guard password.value == confirmPassword.value else {
        HelperK.showError(title: Localizations.passwordNotMatch.localize, subtitle: "")
      return
      
    }
    register(phone: phone.value, password: password.value, email: email.value, name: name.value) { [weak self] value in
      self?.showLoading.accept(false)
      switch value {
        
      case .failure(let error):
        self?.onError.onNext(error.localizedDescription)
        
      case.success(let response):
       
          guard let value = response.response?.data else {return}
          HelperK.saveToken(token: value.accessToken ?? "")
          CoreData.shared.loginModel = value
          HelperK.setUserData(loginPayLoad: value)
        self?.onSuccess.onNext(())
        
      }
    }
  }
  
  
  
}
