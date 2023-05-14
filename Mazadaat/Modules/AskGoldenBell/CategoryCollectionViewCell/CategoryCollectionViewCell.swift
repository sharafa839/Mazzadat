//
//  CategoryCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 14/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sortingLabel: UILabel!
    @IBOutlet weak var coontinerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
     
        setupUI()
    }

    private func setupUI() {
        
        coontinerView.setRoundCorners(15)
    }

    func configureCell(_ by:AdvertisementCategory) {
        if LocalizationManager.shared.getLanguage()?.rawValue ?? "en" == "en" {
            sortingLabel.text = by.name

        }else {
            sortingLabel.text = by.nameAr

        }
        
        coontinerView.backgroundColor = by.selected ? .Bronze_500 : .white
        sortingLabel.textColor =  by.selected ? .white : .textColor
   }
    
}
