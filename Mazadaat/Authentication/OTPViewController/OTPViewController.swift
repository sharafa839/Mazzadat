//
//  OTPViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 17/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import OTPFieldView

class OTPViewController: UIViewController {

    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 5
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.defaultBorderColor = UIColor.black
            self.otpTextFieldView.filledBorderColor = UIColor.green
            self.otpTextFieldView.cursorColor = UIColor.red
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
        }
    
    
}

extension OTPViewController:OTPFieldViewDelegate  {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
    }
}
