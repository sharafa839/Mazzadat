//
//  PlansTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PlansTableViewCell: UITableViewCell {

    @IBOutlet weak var upgradeButton: CustomButton!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var currencyLimitedLabel: UILabel!
    @IBOutlet weak var limittedBidValue: UILabel!
    @IBOutlet weak var yourLimitedTToBidLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var youWillPayLabel: UILabel!
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var containerView: UIView!
    var onTap:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.drawBorder(raduis: 15, borderColor: selected ? .Bronze_500:.Natural_200,borderWidth: 2)

    }
    
    private func setupUI() {
        containerView.applyShadowWithCornerRadius(color: .borderColor, opacity: 0.4, radius: 5, edge: .Bottom_Left, shadowSpace: 1, cornerRadius: 5)
        containerView.setRoundCorners(15)
        upgradeButton.setRoundCorners(25)
        selectionImageView.circle()
        youWillPayLabel.text = Localizations.youPay.localize
        yourLimitedTToBidLabel.text = Localizations.yourLimitBid.localize
        currencyLabel.text = Localizations.SAR.localize
        currencyLimitedLabel.text = Localizations.SAR.localize
    }
    
    func configure(_ with:Subscription) {
        containerView.drawBorder(raduis: 5, borderColor: isSelected ? .Bronze_900:.Natural_200)
        
        packageName.text = with.name
        priceLabel.text = with.price
        limittedBidValue.text = with.gainedBalance
       
        
        if  with.id == CoreData.shared.personalSubscription?.first?.id {
            upgradeButton.setTitle(Localizations.yourCuurrentPlan.localize, for: .normal)
            upgradeButton.backgroundColor = .borderColor
            upgradeButton.isEnabled = false
            }else{
                upgradeButton.setTitle(Localizations.upgrade.localize, for: .normal)
                upgradeButton.isEnabled = true
                upgradeButton.backgroundColor = .Bronze_500
            }
        
    }
    
    @IBAction func upgradeButtonAction(_ sender: UIButton) {
        onTap?()
    }
}
