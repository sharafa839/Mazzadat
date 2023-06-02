//
//  AuctionHolderCellCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 09/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class AuctionHolderCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var auctionHolderTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var auctionHolderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

   private func setupUI() {
       containerView.drawBorder(raduis: 10, borderColor: .Bronze_500)
    }
    
    func setupAuctionHolder(_ auctionHolder: AuctionHolder) {
        auctionHolderTitle.text = auctionHolder.name
        guard let image = auctionHolder.image else {return}
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        auctionHolderImageView.kf.setImage(
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
