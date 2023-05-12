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
        setupLocalize()
        setupObservables()
    }
    
    
    private func setupLocalize() {
        verifyWithNafathTitle.text = Localizations.loginToNafath.localize
        descriptionLabel.text = Localizations.verifyWithNafath.localize
        loginWithNafathButton.setTitle(Localizations.signIn.localize, for: .normal)
        cancelButton.setTitle(Localizations.cancel.localize, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.25, delay: 0.35, options: .curveEaseOut, animations: {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3437071918)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor = .clear
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
