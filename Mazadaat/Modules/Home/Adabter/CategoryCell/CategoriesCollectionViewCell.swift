//
//  CategoriesCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var labelContinerView: UIView!
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.setRoundCorners(10)
        labelContinerView.setRoundCorners(10)
        itemValueLabel.setRoundCorners(10)
        
    }
    func configure(_ category:Category) {
        itemTitleLabel.text = category.name
        itemValueLabel.text = "\(category.auctionCount ?? 0)"
        guard let image = category.image else {return}
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        itemImageView.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
}
