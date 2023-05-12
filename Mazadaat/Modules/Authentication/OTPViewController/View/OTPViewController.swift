//
//  OTPViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 17/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import OTPFieldView
import FirebaseAuth
class OTPViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verifyOtpLabel: UILabel!
    @IBOutlet weak var verifyButton: CustomButton!
    @IBOutlet weak var resendVerificationCodeButton: UIButton!
    @IBOutlet weak var timeInSecondsLabel: UILabel!
    @IBOutlet weak var didntRecieveCodeLabel: UILabel!
    @IBOutlet weak var incorrecetCodeLabel: UILabel!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    var viewModel:OTPViewModel
    var input:String?
    init(viewModel:OTPViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalize()
        setupOtpView()
        setupViewModelObserver()
        setupObservables()
    }

    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 5
            self.otpTextFieldView.fieldBorderWidth = 0.5
            self.otpTextFieldView.defaultBorderColor = UIColor.gray
            self.otpTextFieldView.filledBorderColor = UIColor.textColor
            self.otpTextFieldView.cursorColor = UIColor.red
            self.otpTextFieldView.displayType = .roundedCorner
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
        }
    
    private func setupLocalize() {
        didntRecieveCodeLabel.text = Localizations.dontRecieve.localize
        descriptionLabel.text = Localizations.weHaveSent.localize
        incorrecetCodeLabel.text = Localizations.incorrectCode.localize
        verifyButton.setTitle(Localizations.verify.localize, for: .normal)
        resendVerificationCodeButton.setTitle(Localizations.resendVerificationCode.localize, for: .normal)
        
    }
    
    
    
    private func setupViewModelObserver() {
        viewModel.counter.subscribe { [weak self] timer in
            guard let seconds = timer.element else {return}
            if seconds > 0 {
                self?.resendVerificationCodeButton.isHidden = true
                self?.timeInSecondsLabel.isHidden = false
                self?.didntRecieveCodeLabel.isHidden = false

            }else {
                self?.resendVerificationCodeButton.isHidden = false
                self?.timeInSecondsLabel.isHidden = true
                self?.didntRecieveCodeLabel.isHidden = true
            }
            self?.timeInSecondsLabel.text = "\(seconds)"
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.navigateTo.subscribe { [weak self] value in
            guard let destination = value.element else {return}
            if destination == .forgetPassword {
                self?.navigationController?.pushViewController(ResetPasswordViewController(viewModel: ResetPasswordViewModel(phoneNumber: self?.viewModel.phoneNumber ?? "")), animated: true)
            }else {
                appDelegate.coordinator.setRoot(MainTabBarController())

            }
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupObservables() {
        resendVerificationCodeButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.counter.accept(60)
            self?.viewModel.timerStart()
        }.disposed(by: viewModel.disposeBag)
        verifyButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.verification(code: self?.input ?? "")
        }.disposed(by: viewModel.disposeBag)
    }
    
    
    private func setupUI() {
        setNavigationItem(title: Localizations.verifyYourOtp.localize)
        resendVerificationCodeButton.drawBorder(raduis: 10, borderColor: .Bronze_500)
        resendVerificationCodeButton.isHidden = true
        incorrecetCodeLabel.isHidden = true
        verifyButton.backgroundColor = .gray

    }
    
 
}

extension OTPViewController:OTPFieldViewDelegate  {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        verifyButton.isEnabled = true
        verifyButton.backgroundColor = .Bronze_500
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        
        input = otpString
    }
}
