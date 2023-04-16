//
//  AuctionHolderTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 14/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher

class AuctionHolderTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var auctionPlaceImageView: UIImageView!
    @IBOutlet weak var kindOfAuctionButton: UIButton!
    @IBOutlet weak var countOfAuctionButton: UIButton!
    @IBOutlet weak var startinLabel: UILabel!
    @IBOutlet weak var auctionDaysLabel: UILabel!
    @IBOutlet weak var entryFeeLabel: UILabel!
    @IBOutlet weak var entryFeeValueLabel: UILabel!
    @IBOutlet weak var auctionDaysValueLabel: UILabel!
    @IBOutlet weak var containerDetailesView: UIView!
    @IBOutlet weak var startingInValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupLocalize()
        setupUI()
    }
    
    private func setupLocalize() {
        entryFeeLabel.text = "entryFee"
        startinLabel.text = "startingIn"
        auctionDaysLabel.text = "auctionDays"
    }
    
    private func setupUI() {
        auctionPlaceImageView.setRoundCorners(10)
        containerDetailesView.setRoundCorners(10)
        kindOfAuctionButton.setRoundCorners(10)
        countOfAuctionButton.setRoundCorners(10)
    }
    
    func configure(_ with:AuctionHolderPlaces) {
        let type = AuctionType(rawValue: with.type ?? "")
        switch type {
        case .online:
            kindOfAuctionButton.backgroundColor = .white
            kindOfAuctionButton.setTitleColor(.Bronze_500, for: .normal)
        case .offline:
            kindOfAuctionButton.backgroundColor = .textColor
            kindOfAuctionButton.setTitleColor(.white, for: .normal)
        case .hybrid:
            kindOfAuctionButton.backgroundColor = .Bronze_500
            kindOfAuctionButton.setTitleColor(.white, for: .normal)

        case .none:
            kindOfAuctionButton.backgroundColor = .white
        }
        cityLabel.text = with.name
        kindOfAuctionButton.setTitle(with.type, for: .normal)
       
       
        countOfAuctionButton.backgroundColor = .white
        countOfAuctionButton.setTitle("\(with.auctionsCount ?? 0) Auctions", for: .normal)
        entryFeeValueLabel.text = "\(with.entryFee ?? 0)"
        guard let date = with.auctionTime?.getDate() else {return}
        startingInValueLabel.text = "\(date.day+"d") \(date.hour+"h") \(date.minute+"m")"
        auctionDaysValueLabel.text = date.day + "days"
        guard let image = with.cover else {return}
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        auctionPlaceImageView.kf.setImage(
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

enum AuctionType:String {
    case online = "online"
    case offline = "offline"
    case hybrid =  "hybrid"
}
