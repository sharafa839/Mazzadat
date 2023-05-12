//
//  KindOfAuctionCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 14/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class KindOfAuctionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sortingLabel: UILabel!
    @IBOutlet weak var coontinerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
     
        setupUI()
    }

    private func setupUI() {
        
        coontinerView.setRoundCorners(15)
    }
    
     func configureCell(_ with:KindOFAuction) {
         sortingLabel.text = with.name
         coontinerView.backgroundColor = with.selected ? .textColor : .white
         sortingLabel.textColor = with.selected ? .white : .textColor
    }
    
    func configureCell(_ by:AdvertisementCategory) {
        if LocalizationManager.shared.getLanguage()?.rawValue ?? "en" == "en" {
            sortingLabel.text = by.name

        }else {
            sortingLabel.text = by.nameAr

        }
        
        coontinerView.backgroundColor = isSelected ? .Bronze_500 : .white
        sortingLabel.textColor = isSelected ? .white : .textColor
   }

}

protocol DeqeueCell {
    var name:String? {get}
    var selected:Bool {get}
}
