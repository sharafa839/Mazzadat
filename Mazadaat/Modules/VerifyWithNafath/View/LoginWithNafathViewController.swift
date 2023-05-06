//
//  LoginWithNafathViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class LoginWithNafathViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verifyWithNafathTitle: UILabel!
    @IBOutlet weak var cancelButton: CustomButton!
    @IBOutlet weak var loginWithNafathButton: CustomButton!
    @IBOutlet weak var containerView: UIView!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservables()
    }


    private func setupUI() {
        containerView.setRoundCorners(10)
        cancelButton.backgroundColor = .borderColor
        
    }
    
    private func setupObservables() {
        cancelButton.rx.tap.subscribe { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        loginWithNafathButton.rx.tap.subscribe { [weak self] _ in
          
        }.disposed(by: disposeBag)
    }

}
