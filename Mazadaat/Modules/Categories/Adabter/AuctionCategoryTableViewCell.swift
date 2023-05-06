//
//  AuctionCategoryTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 18/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class AuctionCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var auctionsCountLabel: UILabel!
    @IBOutlet weak var minBidLabel: UILabel!
    @IBOutlet weak var bidView: UIView!
    @IBOutlet weak var auctionTypeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var daysValueLabel: UILabel!
    @IBOutlet weak var endInValueLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var onTapFavoriteButton:(()->Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        containerView.setRoundCorners(5)
        favoriteView.setRoundCorners(favoriteView.frame.height/2)
        bidView.setRoundCorners(bidView.frame.height/2)
        auctionImageView.setRoundCorners(10)
    }
    
    private func setupDate(_ with:CategoryAuctions) {
         let startedAt = Date()
        guard let endAt = with.endAt?.toDateNew() else {return}
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: startedAt, to: endAt)
        
        let seconds = "\(diffDateComponents.second ?? 0)"

        if seconds.contains("-"){
            daysValueLabel.text = "expired"
            endInValueLabel.text = "expired"

        }else {
            endInValueLabel.text = "End In \(diffDateComponents.day ?? 0)d \(diffDateComponents.hour ?? 0)h \(diffDateComponents.minute ?? 0) m"
            daysValueLabel.text = "\(diffDateComponents.day ?? 0) days"

        }
    }
    
     func configure(_ with:CategoryAuctions) {
       //  auctionTypeLabel.text = ""
        setupDate(with)
        favoriteButton.setImage(with.isFavourite ?? false ? UIImage(named: "heart"):UIImage(named: "heart-add-line") , for: .normal)
        favoriteView.backgroundColor = with.isFavourite ?? false ? .Bronze_500 : .lightGray
        priceLabel.text = with.price
        nameLabel.text = with.name
         auctionsCountLabel.text = "\(with.bidsCount ?? 0)"
        minBidLabel.text = with.minimumBid ?? ""
        guard let image = with.media?.first?.file else {return}
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
    
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        onTapFavoriteButton?()
    }
}