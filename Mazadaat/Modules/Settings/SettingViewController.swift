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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setNavigationItem(title: "setting")
    }


    private func setupUI() {
        languageView.setRoundCorners(5)
        auctionAlertView.roundCorners([.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 5)
        promotionView.roundCorners([.layerMinXMaxYCorner,.layerMinXMaxYCorner], radius: 5)
        
    }
}
