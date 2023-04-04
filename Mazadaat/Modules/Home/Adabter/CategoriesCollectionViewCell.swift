//
//  CategoriesCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var labelContinerView: UIView!
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupUI() {
        innerView.setRoundCorners(5)
        labelContinerView.setRoundCorners(15)
        
    }
}
