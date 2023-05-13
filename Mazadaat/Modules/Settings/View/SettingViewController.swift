//
//  SettingViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 29/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var auctionAlertView: UIView!
    @IBOutlet weak var auctionAlertButton: UISwitch!
    @IBOutlet weak var auctionAlertDescriptionLabel: UILabel!
    @IBOutlet weak var auctionAlertLabel: UILabel!
    @IBOutlet weak var languageValue: UILabel!
    @IBOutlet weak var appLanguage: UILabel!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    @IBOutlet weak var bidUpdateButton: UISwitch!
    @IBOutlet weak var bidUpdateDescriptionLabel: UILabel!
    @IBOutlet weak var bidUpdateLabel: UILabel!
    
    @IBOutlet weak var auctionEndingSoonButton: UISwitch!
    @IBOutlet weak var auctionEndingSoonDescriptionLabel: UILabel!
    @IBOutlet weak var auctionEndingSoonLabel: UILabel!
    
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var promotionButton: UISwitch!
    @IBOutlet weak var promotionDescriptionLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    
    var viewModel:SettingViewModel
    init(viewModel:SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalize()
        setupUI()
        setNavigationItem(title: Localizations.settings.localize)
    }

    private func setupLocalize() {
        auctionEndingSoonLabel.text = Localizations.auctionEndingSoon.localize
        auctionAlertDescriptionLabel.text =  Localizations.auctionEndingSoon.localize
        promotionLabel.text = Localizations.promotions.localize
        bidUpdateLabel.text = Localizations.bidUpdates.localize
        bidUpdateDescriptionLabel.text = Localizations.bidUpdates.localize
        auctionAlertLabel.text = Localizations.auctionTitle.localize
        auctionAlertDescriptionLabel.text = Localizations.auctionAlerts.localize
        languageValue.text =  LocalizationManager.shared.getLanguage() == .Arabic ? Localizations.english.localize : Localizations.arabic.localize
        appLanguage.text = "language"
        languageLabel.text = Localizations.appLanguage.localize
        
    }

    private func setupUI() {
        languageView.setRoundCorners(5)
        auctionAlertView.roundCorners([.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 5)
        promotionView.roundCorners([.layerMinXMaxYCorner,.layerMinXMaxYCorner], radius: 5)
        promotionButton.isOn = CoreData.shared.loginModel?.promotions ?? false
        auctionAlertButton.isOn = CoreData.shared.loginModel?.auctionAlerts ?? false
        bidUpdateButton.isOn = CoreData.shared.loginModel?.bidUpdates ?? false
        auctionEndingSoonButton.isOn = CoreData.shared.loginModel?.bidUpdates ?? false
    }
    
    @IBAction func auctionAlertAction(_ sender: UISwitch) {
        let value = sender.isOn
        viewModel.editNotification(autionAlert: value, bidUpdates: nil, promotion: nil, auctionEndingSoon: nil)
    }
    
    @IBAction func bidsUpdateAction(_ sender: UISwitch) {
        let value = sender.isOn
        viewModel.editNotification(autionAlert: nil, bidUpdates: value, promotion: nil, auctionEndingSoon: nil)
    }
    
    @IBAction func auctionEndingSoonActions(_ sender: UISwitch) {
        let value = sender.isOn
        viewModel.editNotification(autionAlert: nil, bidUpdates: nil, promotion: nil, auctionEndingSoon:value )
    }
    
    @IBAction func promotionAction(_ sender: UISwitch) {
        let value = sender.isOn
        viewModel.editNotification(autionAlert: nil, bidUpdates: nil, promotion: value, auctionEndingSoon: nil)
    }
    
    @IBAction func changLanguageAction(_ sender: UIButton) {
        let changeLanguageViewController = LanguageViewController()
        present(changeLanguageViewController, animated: true)
    }
}
