//
//  PackageSubscribePlan.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PackageSubscribePlan: UIView {
//MARK: - IBOutlets
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var upgradeButton: UIButton!
    @IBOutlet weak var remainingValueOfPlan: UILabel!
    @IBOutlet weak var remainingPlanLabel: UILabel!
    
    //MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Properties
    var onTapUpgrade:(()->Void)?
    //MARK: - Methods
    
    private func setupUI() {
        continerView.setRoundCorners(5)
        upgradeButton.setRoundCorners(20)
        
    }
    
    private func setupLocalize() {
        upgradeButton.setTitle("Upgrade", for: .normal)
        
    }
    @IBAction func upgradeButtonAction(_ sender: UIButton) {
    onTapUpgrade?()
    }
}
