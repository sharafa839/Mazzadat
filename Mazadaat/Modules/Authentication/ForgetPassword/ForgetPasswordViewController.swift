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
    
    var viewModel:ForgetPasswordViewModel
    init(viewModel:ForgetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName:nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalize()
        setupUI()
        setupViewModelObservers()
    }

    private func setupLocalize() {
        forgetPasswordLabel.text = Localizations.enterYourMobileNumber.localize
        forgetPasswordDescriptionLabel.text = Localizations.enterYourMobileNumber.localize
        phoneNumberTextField.placeholder = Localizations.enterYourMobileNumber.localize

    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self]_ in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe { [weak self] value in
        
            self?.goToOTPViewController(phonNumber: value.element ?? "")
            
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func goToOTPViewController(phonNumber:String) {
        let otpViewModel = OTPViewModel(phoneNumber:phonNumber , typeOfAuth: .forgetPassword)
        let otpViewController = OTPViewController(viewModel: otpViewModel)
        self.navigationController?.pushViewController(otpViewController, animated: true)
    }
    
    private func setupUI() {
        phoneNumberView.drawBorder(raduis: 10, borderColor: .borderColor)
        setNavigationItem(title: Localizations.forgetPassword.localize)
        sendButton.setTitle("send".localize, for: .normal)
        phoneNumberTextField.map({$0.textAlignment = LocalizationManager.shared.getLanguage() == .Arabic ? .right : .left})
    }

    @IBAction func sendButtonAction(_ sender: CustomButton) {
        guard let text = phoneNumberTextField.text,text.isValidPhone else {
            HelperK.showError(title: Localizations.anError.localize, subtitle: "")
            return
        }
        viewModel.forgetPassword(phoneNumber: text)
       
    }
 
}
