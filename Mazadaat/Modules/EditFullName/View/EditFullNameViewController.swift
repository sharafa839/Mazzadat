//
//  EditFullNameViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 29/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import OTPFieldView
class EditFullNameViewController: UIViewController, didChangePhoneNumber {
    func changePhoneNumber(number: String) {
        phoneNumberTextField.text = number
    }
    


    //MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var fullNameTextContinerView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameSupportingTextLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberTextContainerView: UIView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberSupportingTextLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextContainerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailSupportingTextLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var otpFieldView: OTPFieldView!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var otpSupportingTextLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var oldPasswordTextContainerView: UIView!
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordSupportingTextLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextContainerView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordSupportingTextLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordTextContainerView: UIView!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordSupportingTextLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    //MARK: - Properties
    var viewModel:EditProfilViewModel
    var fullNameDelegate:didChangeFullName?
    var emailDelegate:didChangeEmail?
    var phoneNumberDelegate:didChangePhoneNumber?
    var passwordDelegate:didChangePassword?
    var input = ""
    //MARK: - Init
    init(viewModel:EditProfilViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
        setupObservables()
        setupViewModelObservers()
    }
    
    private func setupUI() {
        saveButton.setRoundCorners(20)
        saveButton.setTitle(Localizations.save.localize, for: .normal)
        dismissButton.circle()
        parentView.setRoundCorners(20)
        viewModel.isContinueButtonEnabled.bind(to:  saveButton.rx.isEnabled).disposed(by: viewModel.disposeBag)

        let type = viewModel.type
        
        switch type {
        case .name:
           setupFullName()
        case .email:
            setupEmail()
        case .password:
            setupPassword()
        case .phone:
            setupPhoneNumber()
        case .verify:
            setupOTP()
        }
    }
    
    private func setupFullName() {
        fullNameView.isHidden = false
        titleLabel.text = Localizations.displayName.localize
        fullNameLabel.text = Localizations.displayName.localize
        fullNameSupportingTextLabel.text = Localizations.supportingText.localize
        fullNameTextField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: viewModel.disposeBag)
        fullNameTextContinerView.drawBorder(raduis: 5, borderColor: .black)
    }
    
    private func setupEmail() {
        emailView.isHidden = false
        titleLabel.text = Localizations.emilAddress.localize
        emailLabel.text = Localizations.emilAddress.localize
        emailSupportingTextLabel.text =  Localizations.supportingText.localize
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: viewModel.disposeBag)
        emailTextContainerView.drawBorder(raduis: 5, borderColor: .black)
    }
    
    private func setupPhoneNumber() {
        phoneNumberView.isHidden = false
        titleLabel.text =   Localizations.phoneNumber.localize
        phoneNumberLabel.text = Localizations.phoneNumber.localize
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberSupportingTextLabel.text = Localizations.supportingText.localize
        phoneNumberTextField.rx.text.orEmpty.bind(to: viewModel.phone).disposed(by: viewModel.disposeBag)
        phoneNumberTextContainerView.drawBorder(raduis: 5, borderColor: .black)
    }
    
    private func setupOTP() {
        setupOtpView()
        otpView.isHidden = false
        titleLabel.text = Localizations.verifyPhoneNumber.localize
        otpLabel.text = Localizations.verifyYourOtp.localize
        otpSupportingTextLabel.text = Localizations.weHaveSent.localize
    }
    
    func setupOtpView(){
            self.otpFieldView.fieldsCount = 5
            self.otpFieldView.fieldBorderWidth = 0.5
            self.otpFieldView.defaultBorderColor = UIColor.gray
            self.otpFieldView.filledBorderColor = UIColor.textColor
            self.otpFieldView.cursorColor = UIColor.red
            self.otpFieldView.displayType = .roundedCorner
            self.otpFieldView.fieldSize = 20
            self.otpFieldView.separatorSpace = 2
            self.otpFieldView.delegate = self
            self.otpFieldView.initializeUI()
        
        }
    
    private func setupPassword() {
        passwordView.isHidden = false
        confirmPasswordView.isHidden = false
        oldPasswordView.isHidden = false
        titleLabel.text = Localizations.changePassword.localize
        passwordLabel.text = Localizations.newPassword.localize
        passwordSupportingTextLabel.text = Localizations.supportingText.localize
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.newPassword).disposed(by: viewModel.disposeBag)
        passwordTextContainerView.drawBorder(raduis: 5, borderColor: .borderColor)
        
        confirmPasswordLabel.text = Localizations.confirmPassword.localize
        confirmPasswordSupportingTextLabel.text = Localizations.supportingText.localize
        confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.confirmPassword).disposed(by: viewModel.disposeBag)
        confirmPasswordTextContainerView.drawBorder(raduis: 5, borderColor: .borderColor)
        
        oldPasswordLabel.text = Localizations.oldPassword.localize
        oldPasswordSupportingTextLabel.text = Localizations.supportingText.localize
        oldPasswordTextField.rx.text.orEmpty.bind(to: viewModel.oldPassword).disposed(by: viewModel.disposeBag)
        oldPasswordTextContainerView.drawBorder(raduis: 5, borderColor: .borderColor)
    }
    
    
    private func setupObservables() {
        saveButton.rx.tap.subscribe { [weak self] _ in
            self?.setupSaveButton()
            
        }.disposed(by: viewModel.disposeBag)
        
        dismissButton.rx.tap.subscribe { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] value in
            
        }.disposed(by: viewModel.disposeBag)
       

        viewModel.onGetData.subscribe { [weak self] value in
            guard let data = value.element else {return}
            self?.fullNameDelegate?.changeFullName(name: data.name ?? "")
            self?.emailDelegate?.changeEmail(Email: data.email ?? "")
            self?.phoneNumberDelegate?.changePhoneNumber(number: data.mobile ?? "")
            self?.dismiss(animated: true)
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupSaveButton() {
        let type = viewModel.type
        switch type {
        case .name:
            guard let name = fullNameTextField.text , !name.isEmpty else {return}
            
            viewModel.updatePersonalInformation(name: name)
            
        case .email:
            guard let email = emailTextField.text , !email.isEmpty else {return}
            
            viewModel.updatePersonalInformation(email: email)
          
        case .password:
            viewModel.changePassword()
        case .phone:
            let editViewmodel = EditProfilViewModel(type: .verify)
            let editProfileViewController = EditFullNameViewController(viewModel: editViewmodel)
            editViewmodel.getVerificationCode()
            editProfileViewController.phoneNumberDelegate = self.self
            self.navigationController?.pushViewController(editProfileViewController, animated: true)
        case .verify:
            viewModel.verify(verificationCode: input)
            

        }
      
    }
    
   
    
    //MARK: - Methods

}


extension EditFullNameViewController:OTPFieldViewDelegate  {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        saveButton.isEnabled = true
        saveButton.backgroundColor = .Bronze_500
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
