//
//  OTPViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 16/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
import FirebaseAuth
class OTPViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var phoneNumber:String
    var typeOfAuth:AuthState
    var verificationID:String?
    var navigateTo = PublishSubject<AuthState>()
    var incorrectCode = PublishSubject<Void>()
    var counter = BehaviorRelay<Int>(value: 60)
    var timer:Timer?
    init(phoneNumber:String,typeOfAuth:AuthState) {
        self.phoneNumber = phoneNumber
        self.typeOfAuth = typeOfAuth
        getVerificationCode()
    }
    
    func getVerificationCode()  {
        counter.accept(60)
        timerStart()
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
                self?.incorrectCode.onNext(())
                print(error?.localizedDescription)
            }
            self?.navigateTo.onNext(self?.typeOfAuth ?? .forgetPassword)
        }
        
    }
    
    func timerStart() {
           timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       }



    @objc func updateCounter() {
        if counter.value > 0 {
            counter.accept(counter.value - 1)
        }else {
            timer?.invalidate()
            counter.accept(0)
        }
    }
    
}


enum AuthState {
    case register
    case forgetPassword
}
