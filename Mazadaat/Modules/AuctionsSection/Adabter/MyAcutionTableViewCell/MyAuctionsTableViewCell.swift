//
//  MyAuctionsTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 27/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class MyAuctionsTableViewCell: UITableViewCell {

    @IBOutlet weak var biddingView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var auctionNameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var yourBidWonLabel: UILabel!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
        setupLocalize()
    }
    
    private func setupUI() {
        containerView.setRoundCorners(20)
        instructionView.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 20)
        biddingView.setRoundCorners(10)
        
    }
    
    private func setupLocalize() {
        yourBidWonLabel.text = "yourBidWon".localize
        currencyLabel.text = Localizations.SAR.localize
    }
    
 
    func configure(_ with:FavoriteModel) {
        priceLabel.text = with.price
        auctionNameLabel.text = with.name
        instructionLabel.text = AuctionStatus(rawValue: with.status ?? 0)?.status
        guard let image = with.category?.image else {return}
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        auctionImageView.kf.setImage(
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
