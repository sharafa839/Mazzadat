//
//  OnBoardingCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 29/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var detailesOnBoardingLabel: UILabel!
    @IBOutlet weak var titleOnBoardingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Methods
    
    func configure(items:OnBoardingModel) {
        imageView.image = items.image
        detailesOnBoardingLabel.text = items.description
        titleOnBoardingLabel.text = items.title
    }
}
