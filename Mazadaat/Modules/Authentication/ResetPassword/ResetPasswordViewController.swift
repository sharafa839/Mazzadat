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
    
    //MARK: - Init
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

setupUI()
        setupLocalize()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        confirmPassewordView.drawBorder(raduis: 10, borderColor: .borderColor)
        passewordView.drawBorder(raduis: 10, borderColor: .borderColor)
       
        
    }
    
    private func setupLocalize() {
      
        passwordTextField.placeholder = "enterPassword"
       
        confirmPasswordTextField.placeholder = "confirmPassword"
        saveButton.setTitle("save", for: .normal)
        
    }
}
