//
//  RegisterViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 17/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var langaugeButton: UIButton!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var welcomeDescriptionLabel: UILabel!
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var kindOfAuhenticationSectionSegment: UISegmentedControl!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var loginWithNafathButton: UIButton!
    @IBOutlet weak var ContinueAsGuestButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passewordView: UIView!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var confirmPassewordView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    @IBOutlet weak var loginAsGuestView: UIView!

    @IBOutlet weak var loginWithNafathView: UIView!


    //MARK: - Properties
    private var viewModel:RegisterViewModel
    //MARK: - Init
    init(viewModel:RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalize()
        setupUI()
        setupProperty()
        setupViewModelObserver()
        setupObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
   
    //MARK: - Methods
    
    private func setupUI() {
        
        fullNameView.drawBorder(raduis: 10, borderColor: .borderColor)
        phoneNumberView.drawBorder(raduis: 10, borderColor: .borderColor)
        confirmPassewordView.drawBorder(raduis: 10, borderColor: .borderColor)
        emailView.drawBorder(raduis: 10, borderColor: .borderColor)
        loginWithNafathView.setRoundCorners(25)
        loginAsGuestView.setRoundCorners(25)
        phoneNumberView.drawBorder(raduis: 10, borderColor: .borderColor)
        passewordView.drawBorder(raduis: 10, borderColor: .borderColor)
        languageView.drawBorder(raduis: 10, borderColor: .borderColor)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.Bronze_900]
            kindOfAuhenticationSectionSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
            kindOfAuhenticationSectionSegment.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
    }
    
    private func setupLocalize() {
        guard let currentLanguage = LocalizationManager.shared.getLanguage() else {return}
        if  currentLanguage == .Arabic {
            langaugeButton.setTitle(Localizations.english.localize, for: .normal)
        }else {
            langaugeButton.setTitle(Localizations.arabic.localize, for: .normal)
        }
        welcomeDescriptionLabel.text = Localizations.welcome.localize
        welcomeTitleLabel.text = Localizations.goodToSeeYou.localize
        kindOfAuhenticationSectionSegment.setTitle(Localizations.signIn.localize, forSegmentAt: 0)
        kindOfAuhenticationSectionSegment.setTitle(Localizations.register.localize, forSegmentAt: 1)
        loginButton.setTitle(Localizations.signIn.localize, for: .normal)
        loginWithNafathButton.setTitle(Localizations.loginToNafath.localize, for: .normal)
        ContinueAsGuestButton.setTitle(Localizations.continueAsGuest.localize, for: .normal)
        phoneNumberTextField.placeholder = Localizations.enterYourMobileNumber.localize
        passwordTextField.placeholder = Localizations.enterPassword.localize
        orLabel.text = Localizations.or.localize
        confirmPasswordTextField.placeholder = Localizations.confirmPassword.localize
        emailTextField.placeholder = Localizations.enterYourEmail.localize
        kindOfAuhenticationSectionSegment.selectedSegmentIndex = 1
        fullNameTextField.placeholder = Localizations.enterYourFullName.localize
       
    }
    
    
    
    private func setupProperty() {
      phoneNumberTextField.rx.text.orEmpty.bind(to: viewModel.phone).disposed(by: viewModel.disposeBag)
      passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: viewModel.disposeBag)
      emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: viewModel.disposeBag)
      fullNameTextField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: viewModel.disposeBag)
      confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.confirmPassword).disposed(by: viewModel.disposeBag)
      viewModel.isContinueButtonEnabled.bind(to:  loginButton.rx.isEnabled).disposed(by: viewModel.disposeBag)
    }
    
    
    private func setupViewModelObserver() {
      viewModel.showLoading.subscribe { [weak self] value in
        guard let isLoading = value.element else {return}
          isLoading ? ActivityIndicatorManager.shared.showProgressView() : ActivityIndicatorManager.shared.hideProgressView()
      }.disposed(by: viewModel.disposeBag)

      viewModel.onError.subscribe {  error in
        guard let errorDescription = error.element else {return}
        HelperK.showError(title: errorDescription, subtitle: "")
      }.disposed(by: viewModel.disposeBag)

      viewModel.onSuccess.subscribe { [weak self] _ in
          self?.navigationController?.pushViewController(OTPViewController(viewModel: OTPViewModel(phoneNumber: self?.viewModel.phone.value ?? "", typeOfAuth: .register)), animated: true)
      }.disposed(by: viewModel.disposeBag)

    }
    

    
    private func setupObservables() {
        loginButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.signUp()
        }.disposed(by: viewModel.disposeBag)
        
       
        showPasswordButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}

            self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        }.disposed(by: viewModel.disposeBag)
        confirmPasswordButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}

            self.confirmPasswordTextField.isSecureTextEntry = !self.confirmPasswordTextField.isSecureTextEntry
        }.disposed(by: viewModel.disposeBag)
        
        loginWithNafathButton.rx.tap.subscribe { [weak self] in
            
        }.disposed(by: viewModel.disposeBag)
        
        langaugeButton.rx.tap.subscribe { [weak self] _ in
            guard let currentLanguage = LocalizationManager.shared.getLanguage() else {return}
            guard currentLanguage == .Arabic else {
                LocalizationManager.shared.setLanguage(language: .English)

                return
            }
            LocalizationManager.shared.setLanguage(language: .Arabic)

        }.disposed(by: viewModel.disposeBag)
        
        
    }
    
    @IBAction func segmentAction(_ sender: CustomSegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            let registerViewController = LoginViewController(viewModel: LoginViewModel())
            AppUtilities.changeRoot(root: registerViewController)
        }
    }
    
    @IBAction func asGuest(_ sender: UIButton) {
        AppUtilities.changeRoot(root: MainTabBarController())

    }
    
}


