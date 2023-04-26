//
//  ForgetPasswordViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 17/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var sendButton: CustomButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var forgetPasswordDescriptionLabel: UILabel!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalize()
        setupUI()
    }

    private func setupLocalize() {
        forgetPasswordLabel.text = "enterThePhoneNumberRelatedToYourAccount"
        forgetPasswordDescriptionLabel.text = "enterThePhoneNumberRelatedToYourAccount"
        phoneNumberTextField.placeholder = "enterYourMobileNumber"

    }
    
    private func setupUI() {
        phoneNumberView.drawBorder(raduis: 10, borderColor: .borderColor)
        setNavigationItem(title: "ForgetPassword")
    }

    @IBAction func sendButtonAction(_ sender: CustomButton) {
        guard let text = phoneNumberTextField.text,text.isValidPhone else {
            HelperK.showError(title: "haveToTypeYourPhoneNumber", subtitle: "")
            return
        }
        let otpViewModel = OTPViewModel(phoneNumber: text, typeOfAuth: .forgetPassword)
        let otpViewController = OTPViewController(viewModel: otpViewModel)
        self.navigationController?.pushViewController(otpViewController, animated: true)
    }
 
}
