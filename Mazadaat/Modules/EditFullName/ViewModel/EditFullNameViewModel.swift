//
//  EditFullNameViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 29/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
import FirebaseAuth
protocol didChangeFullName {
    func changeFullName(name:String)
}

protocol didChangePhoneNumber {
    func changePhoneNumber(number:String)
}

protocol didChangePassword {
    func changePassword(password:String)
}

protocol didChangeEmail {
    func changeEmail(Email:String)
}

class EditProfilViewModel:AuthNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var newPassword = BehaviorRelay<String>(value: "")
    var oldPassword = BehaviorRelay<String>(value: "")
    var confirmPassword = BehaviorRelay<String>(value: "")
    var onSuccess = PublishSubject<Void>()
    var onGetData = PublishSubject<LoginPayload>()
    var email = BehaviorRelay<String>(value: "")
    var name = BehaviorRelay<String>(value: "")
    var phone = BehaviorRelay<String>(value: "")
    var verificationID:String?
    var isNewPasswordValid : Observable<Bool> {
      return newPassword.asObservable().map { (isPasswordPropriety) in
        return isPasswordPropriety.count > 5
      }
    }
    var isOldPasswordValid : Observable<Bool> {
      return oldPassword.asObservable().map { (isPasswordPropriety) in
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
    
    var isPhoneEmpty : Observable<Bool> {
      return phone.asObservable().map { (phoneIsValid)->Bool in
        return !(phoneIsValid.isEmpty)
      }
    }
    
    
    var isConfirmPasswordValid : Observable<Bool> {
      return confirmPassword.asObservable().map { (isPasswordPropriety) in
        return isPasswordPropriety.count > 5
      }
    }

    var isContinueButtonEnabled:Observable<Bool>{
   
        return Observable.combineLatest(isConfirmPasswordValid,isNewPasswordValid,isOldPasswordValid,isEmailValid,isNameValid,isPhoneEmpty){(confirm,newpass,oldPass,email,name,phone) in
            return (confirm  && newpass && oldPass) || (email) || (name) || (phone)
        }
    }
    
    var type:EditProfileType
    
    init(type:EditProfileType) {
        self.type = type
        
    }
    
    func updatePersonalInformation(name:String = HelperK.getname(),phone:String = HelperK.getphone(),email:String = HelperK.getemail()) {
        onLoading.accept(true)
        update(name: name, phone: phone, email: email) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let loginPayload = response.response?.data else {return}
                HelperK.setUserData(loginPayLoad: loginPayload)
                self?.onGetData.onNext(loginPayload)
            }
        }
    }
    
    
   
    func changePassword() {
        guard newPassword.value == confirmPassword.value else {
            onError.onNext("notMatching")
            return
        }
        onLoading.accept(true)
        changePassword(currentPassword: oldPassword.value, newPassword: newPassword.value) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let loginPayload = response.response?.data else {return}
                HelperK.setUserData(loginPayLoad: loginPayload)
                HelperK.saveToken(token: loginPayload.accessToken ?? "")
                self?.onSuccess.onNext(())
            }
        }
    }
    
    
    func getVerificationCode()  {
        
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting=false

        PhoneAuthProvider.provider().verifyPhoneNumber("+201100638509", uiDelegate: nil) {[weak self] (verificationID, error) in
            if let error = error {
           
                print("error \(error.localizedDescription)")
                return
            }
            if verificationID != nil {
                self?.verificationID = verificationID!
            }
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    func verify(verificationCode:String) {
       
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "",
            verificationCode: verificationCode)
        
        
        Auth.auth().signIn(with: credential) {[weak self] (authResult, error) in
            if error != nil {
                self?.onError.onNext(error?.localizedDescription ?? "")
                print(error?.localizedDescription ?? "")
            }
            self?.updatePersonalInformation(phone: self?.phone.value ?? "")
            
        }
        
    }
   
}

enum EditProfileType {
    case name,email,password,phone,verify
}
