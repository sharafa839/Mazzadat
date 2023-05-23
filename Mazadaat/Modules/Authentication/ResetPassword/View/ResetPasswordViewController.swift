//
//  ResetPasswordViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 17/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passewordView: UIView!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var confirmPassewordView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    //MARK: - Properties
    var viewModel:ResetPasswordViewModel
    //MARK: - Init
    init(viewModel:ResetPasswordViewModel) {
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
        setupLocalize()
        setupViewModelObserver()
        setupViewModel()
        setupProperty()
        setupObservables()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        confirmPassewordView.drawBorder(raduis: 10, borderColor: .borderColor)
        passewordView.drawBorder(raduis: 10, borderColor: .borderColor)
       setNavigationItem(title:Localizations.resetPassword.localize)
        [passwordTextField,confirmPasswordTextField].map({$0?.textAlignment = LocalizationManager.shared.getLanguage() == .Arabic ? .right : .left})

    }
    
    private func setupProperty() {
      
      passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: viewModel.disposeBag)
      confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.confirmPassword).disposed(by: viewModel.disposeBag)
      viewModel.isContinueButtonEnabled.bind(to:  saveButton.rx.isEnabled).disposed(by: viewModel.disposeBag)
     
    }
    
    private func setupLocalize() {
      
        passwordTextField.placeholder = Localizations.enterPassword.localize
        confirmPasswordTextField.placeholder = Localizations.confirmPassword.localize
        saveButton.setTitle(Localizations.enterYourMobileNumber.localize, for: .normal)
        
    }
    
    private func setupObservables() {
        confirmPasswordButton.rx.tap.subscribe { [weak self]_ in
            self?.confirmPasswordTextField.isSecureTextEntry = !(self?.confirmPasswordTextField.isSecureTextEntry ?? false)
        }.disposed(by: viewModel.disposeBag)
        
        showPasswordButton.rx.tap.subscribe { [weak self] _ in
            self?.passwordTextField.isSecureTextEntry = !(self?.passwordTextField.isSecureTextEntry ?? false)
        }.disposed(by: viewModel.disposeBag)
        
        saveButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.resetPassword()
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupViewModel() {
        
    }
    
    private func setupViewModelObserver() {
        viewModel.onSuccess.subscribe { [weak self] _ in
            let resetPasswordSuccessViewModel = SuccessResetPasswordViewModel(success: true, title: Localizations.resetPassword.localize, subtitle:Localizations.resetPassword.localize, descrption: "", type: .forgetPassword)
            let resetPasswordViewController = SuccessResetPassowrdViewController(viewModel: resetPasswordSuccessViewModel)
            self?.present(resetPasswordViewController, animated: true, completion: nil)
            
        }.disposed(by: viewModel.disposeBag)

        viewModel.onLoading.subscribe { [weak self] value in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "" , subtitle: "")
            let resetPasswordSuccessViewModel = SuccessResetPasswordViewModel(success: false, title: Localizations.failed.localize, subtitle:Localizations.anError.localize, descrption: nil, type: .forgetPassword)
            let resetPasswordViewController = SuccessResetPassowrdViewController(viewModel: resetPasswordSuccessViewModel)
            self?.present(resetPasswordViewController, animated: true, completion: nil)
            
        }.disposed(by: viewModel.disposeBag)
    }
}
