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
}
