//
//  RestPasswordVerfiyVC.swift
//  Mazadaat
//
//  Created by macbook on 12/25/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import OTPFieldView

class RestPasswordVerfiyVC: UIViewController {

    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var codeView: OTPFieldView!
    
    var code = 0 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
    }
    
    @IBAction func restTapped(_ sender: Any) {
        chnagePass()
    }
    func setupOtpView(){
        self.codeView.fieldsCount = 5
        self.codeView.fieldBorderWidth = 1
        self.codeView.defaultBorderColor = UIColor(hexString: "D1D1D1")
        self.codeView.filledBorderColor = UIColor(hexString: "12B0E7")
        self.codeView.cursorColor = UIColor(hexString: "12B0E7")
        self.codeView.displayType = .square
        self.codeView.fieldSize = 40
        self.codeView.separatorSpace = 8
        self.codeView.shouldAllowIntermediateEditing = false
        self.codeView.delegate = self
        self.codeView.initializeUI()
    }
    
    func chnagePass(){
        
        if email.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال البريد الالكتروني".localized)
            return
        }
        
        if newPass.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال كلمة المرور الجديدة".localized)
            return
        }
        
        if confirmPass.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء تأكيد كلمة المرور".localized)
            return
        }
        
        DataClient.restPass(email: self.email.text!, newPass: self.newPass.text!, confrimPass: self.confirmPass.text!, code: code,success: { (dict) in
            
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "SplashVC")
            UIApplication.shared.windows.first?.rootViewController = newViewcontroller
            UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//
//            let storyboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "RestPasswordVerfiyVC") as?  RestPasswordVerfiyVC
//
//                self.navigationController?.pushViewController(vc!, animated: true)
//
//

            
              }, failure: { (err) in
                  
                                 self.errorAlert(title: "Alert", body:  err)
                  
              })

     }
    
    
    
}




extension RestPasswordVerfiyVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    
    
    func enteredOTP(otp otpString: String) {
//        print("OTPString: \(otpString)")
//        self.sendCodeToAPI(code:  otpString )
        code =  Int(otpString) ?? 0
    }
    
    
    private func openRestPasswordVC(phoneNumber:String){
        
//
//        let vc = UIStoryboard.init(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgetPassVC") as? ForgetPassVC
//        vc?.linkStr = link
//        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

    private func openRegisterVC(phoneNumber:String){
        
//
//        let vc = UIStoryboard.init(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC
//        vc?.mobilNo = phoneNumber
//        vc?.link = link
//        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
