//
//  VerfiyCodeVC.swift
//  Mazadaat
//
//  Created by macbook on 10/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import OTPFieldView

class VerfiyCodeVC: UIViewController {
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    var code = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDesc.text = "تم ارسال رمز التحقق الى البريد الالكتروني: \(AppData.email)"
//        verifyData()

        
setupOtpView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    
    func setupOtpView(){
        self.otpView.fieldsCount = 5
        self.otpView.fieldBorderWidth = 1
        self.otpView.defaultBorderColor = UIColor(hexString: "D1D1D1")
        self.otpView.filledBorderColor = UIColor(hexString: "12B0E7")
        self.otpView.cursorColor = UIColor(hexString: "12B0E7")
        self.otpView.displayType = .square
        self.otpView.fieldSize = 40
        self.otpView.separatorSpace = 8
        self.otpView.shouldAllowIntermediateEditing = false
        self.otpView.delegate = self
        self.otpView.initializeUI()
    }
    
    
    func verifyData(){
        DataClient.verifyEmail(type:1,success: { (dict) in
            
print("xxxx")
            self.toastAlert(title: "تم ارسال كود التحقق".localized)

        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    
    func verifyCode(code: Int){
           
           DataClient.addCodeVerfiy(code: code, type: 1,success: { (dict) in

            AppData.isVeerfiyEmail = true
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
            UIApplication.shared.windows.first?.rootViewController = newViewcontroller
            UIApplication.shared.windows.first?.makeKeyAndVisible()
           }, failure: { (err) in

                         self.errorAlert(title: "", body: err)
           })
       }
    
    @IBAction func confirmBtn(_ sender: Any) {
        
        if code == 0 {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال كود التحقق")
            return
        }
        verifyCode(code: code)

    }
    
    
    @IBAction func sendCodeTapped(_ sender: Any) {
        self.verifyData()
    }
    
    
    @IBAction func skipTapped(_ sender: Any) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
        UIApplication.shared.windows.first?.rootViewController = newViewcontroller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    
}


extension VerfiyCodeVC: OTPFieldViewDelegate {
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
