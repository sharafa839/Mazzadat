//
//  ContactUsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 30/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxSwift

class ContactUsViewController: UIViewController {


    //MARK: - IBOutlets
    @IBOutlet weak var phoneContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mobilePhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobilePhoneButton: UIButton!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    //MARK: - Init
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupObservables()
        setupLocalize()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        phoneContainerView.setRoundCorners(5)
        emailContainerView.setRoundCorners(5)
        setNavigationItem(title: Localizations.contactUs.localize)
        imageView.circle()
    }
    
    private func setupLocalize() {
        emailLabel.text = Localizations.emailUs.localize
        mobilePhoneLabel.text = Localizations.callUs.localize
    }
    
    private func setupObservables() {
        mobilePhoneButton.rx.tap.subscribe  { [weak self] _ in
            HelperK.openCalling(phone: CoreData.shared.settings?.mobile ?? "")
        }.disposed(by: disposeBag)
        
        emailButton.rx.tap.subscribe  { [weak self] _ in
            HelperK.openEmail(email: CoreData.shared.settings?.email ?? "")
        }.disposed(by: disposeBag)
    }
    
}
