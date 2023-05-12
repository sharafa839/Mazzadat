//
//  LoginViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 01/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var langaugeButton: UIButton!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var welcomeDescriptionLabel: UILabel!
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var kindOfAuhenticationSectionSegment: CustomSegmentedControl!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var loginWithNafathButton:LoginWithOtherSideButton!
    @IBOutlet weak var ContinueAsGuestButton: LoginWithOtherSideButton!
    @IBOutlet weak var loginAsGuestView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passewordView: UIView!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var loginWithNafathView: UIView!
    //MARK: - Properties
    private var viewModel:LoginViewModel
    //MARK: - Init
    init(viewModel:LoginViewModel) {
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
        setupObservables()
        setupViewModelObserver()
        setupProperty()
        print("\(self.view.semanticContentAttribute.rawValue)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    //MARK: - Methods
    
    private func setupUI() {
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
        kindOfAuhenticationSectionSegment.selectedSegmentIndex = 0
        forgetPasswordButton.setTitle(Localizations.forgetPassword.localize, for: .normal)
     
    }
    
    private func setupObservables() {
        loginButton.rx.tap.subscribe { [weak self] _  in
            self?.viewModel.loginWithPhoneAndPassword()
        }.disposed(by: viewModel.disposeBag)
        
        showPasswordButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}

            self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        }.disposed(by: viewModel.disposeBag)
  
       
        
        forgetPasswordButton.rx.tap.subscribe { [weak self] _ in
            let forgetPasswordViewController = ForgetPasswordViewController()
            self?.navigationController?.pushViewController(forgetPasswordViewController, animated: true)
        }.disposed(by: viewModel.disposeBag)
        
    }
    @IBAction func langChange(_ sender: UIButton) {
        guard let currentLanguage = LocalizationManager.shared.getLanguage() else {return}
        if currentLanguage == .Arabic  {
            LocalizationManager.shared.setLanguage(language: .English)
           
            return
        }else{
            LocalizationManager.shared.setLanguage(language: .Arabic)
          return
        }

    }
    
    private func setupViewModelObserver() {
      viewModel.showLoading.subscribe { [weak self] value in
        guard let isLoading = value.element else {return}
          isLoading ? ActivityIndicatorManager.shared.showProgressView() : ActivityIndicatorManagerr.shared.hideProgressView()
      }.disposed(by: viewModel.disposeBag)

      viewModel.onError.subscribe {  error in
        guard let errorDescription = error.element else {return}
        HelperK.showError(title: errorDescription, subtitle: "")
      }.disposed(by: viewModel.disposeBag)

      viewModel.onSuccess.subscribe { [weak self] _ in
          let tabBarViewController = MainTabBarController()
          self?.navigationController?.pushViewController(tabBarViewController, animated: true)
      }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupProperty() {
      
      phoneNumberTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: viewModel.disposeBag)
      passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: viewModel.disposeBag)
     // viewModel.isContinueButtonEnabled.bind(to:  loginButton.rx.isEnabled).disposed(by: viewModel.disposeBag)
     
    }
    @IBAction func segmentAction(_ sender: CustomSegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            let registerViewController = RegisterViewController(viewModel: RegisterViewModel())
            AppUtilities.changeRoot(root: UINavigationController(rootViewController: registerViewController))

        }
    }
    
    @IBAction func asGuest(_ sender: UIButton) {
        AppUtilities.changeRoot(root: MainTabBarController())

    }
}


