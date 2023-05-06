//
//  SuccessResetPassowrdViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 03/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class SuccessResetPassowrdViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var doneButton: CustomButton!
    @IBOutlet weak var rejectButton: CustomButton!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    //MARK: - Properties
    var delegate:HeightsBidding?
    var viewModel:SuccessResetPasswordViewModel
    //MARK: - Init
    init(viewModel:SuccessResetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupUI()
        setupObservables()
    }
    
    private func setupViewModel() {
        statusLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        subTitleLabel.text = viewModel.subTitle
    }
    
    private func setupUI() {
        rejectButton.isHidden = !viewModel.success
         navigationController?.isNavigationBarHidden =  viewModel.success
    }
    
    private func setupObservables() {
        doneButton.rx.tap.subscribe { [weak self] _  in
            if self?.viewModel.opensource == .auction {
                self?.delegate?.didBidding()
                self?.dismiss(animated: true, completion: nil)
            }else {
                self?.setRoot(LoginViewController(viewModel: LoginViewModel()), withNavigation: true, animated: true)
            }
            
        }.disposed(by: viewModel.disposeBag)

    }
    
    
    //MARK: - Methods
}
