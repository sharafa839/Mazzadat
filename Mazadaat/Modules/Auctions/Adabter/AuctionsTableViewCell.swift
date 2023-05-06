//
//  AuctionsTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 15/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class AuctionsTableViewCell: UITableViewCell {

    @IBOutlet weak var biddingImageView: UIImageView!
    @IBOutlet weak var biddingValueLabel: UILabel!
    @IBOutlet weak var biddingStatusLabel: UILabel!
    @IBOutlet weak var biddingStatusView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var auctionsCountLabel: UILabel!
    @IBOutlet weak var endInLabel: UILabel!
    @IBOutlet weak var auctionContinerView: UIView!
    @IBOutlet weak var endInView: UIView!
    
     var onTapFavoriteButton:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        heartView.setRoundCorners(heartView.frame.height/2)
        containerView.setRoundCorners(10)
        auctionImageView.setRoundCorners(10)
        auctionContinerView.setRoundCorners(auctionContinerView.frame.height/2)
        countView.setRoundCorners(10)
        endInView.setRoundCorners(10)
        biddingStatusView.setRoundCorners(5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupDate(_ end:String,_ start:String) {
         let startedAt = Date()
        guard let endAt = end.toDateNew() else {return}
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: startedAt, to: endAt)
        
        let seconds = "\(diffDateComponents.second ?? 0)"

        if seconds.contains("-"){
            endInLabel.text = "expired"

        }else {
            endInLabel.text = "\(diffDateComponents.day ?? 0)d \(diffDateComponents.hour ?? 0)h \(diffDateComponents.minute ?? 0) m"


        }
    }
    
    func configure(_ with:Auction) {
        setTitleColorForBidding()
        biddingStatusView.isHidden = true
        minLabel.text = "min"
        minValue.text = with.minimumBid
        favoriteButton.setImage(with.isFavourite ?? false ? UIImage(named: "heart"):UIImage(named: "heart-add-line") , for: .normal)
        heartView.backgroundColor = with.isFavourite ?? false ? .Bronze_500 : .lightGray
        priceLabel.text = with.price
        titleLabel.text = with.name
        auctionsCountLabel.text = "\(with.bidsCount ?? 0)"
        guard let date = with.endAt?.getDate() else {return}
        
        endInLabel.text = "\(date.day+"d") \(date.hour+"h") \(date.minute+"m")"
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
    
    
    func configureToGoldenList(with:FavoriteModel) {
        biddingStatusView.isHidden = true
        
        minLabel.text = "min"
        minValue.text = with.minimumBid
        favoriteButton.setImage( UIImage(systemName: "trash"), for: .normal)
        heartView.backgroundColor = with.isFavourite ?? false ? .Bronze_500 : .lightGray
        priceLabel.text = with.price
        titleLabel.text = with.name
        auctionsCountLabel.text = "\(with.bidsCount ?? 0)"
        guard let date = with.endAt?.getDate() else {return}
        
        endInLabel.text = "\(date.day+"d") \(date.hour+"h") \(date.minute+"m")"
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
    
    func setTitleColorForBidding() {
        minValue.textColor = .white
        minLabel.textColor = .white
        priceLabel.textColor = .white
        titleLabel.textColor = .white
    }
    
    func configureToBidding(with:FavoriteModel) {
        
        setTitleColorForBidding()
        if with.lastBid?.userID == HelperK.getId() {
            biddingStatusLabel.text = "yourTheHeighstNow"
            biddingValueLabel.text =  with.lastBid?.price ?? ""
            biddingStatusView.backgroundColor = .Bronze_100
            biddingValueLabel.textColor = .Bronze_900
            biddingStatusLabel.textColor = .Bronze_900
        }else {
            biddingStatusLabel.text = "yourOutBid"
            biddingValueLabel.text = "AgainToLead"
            biddingStatusView.backgroundColor = .Natural_200
            biddingValueLabel.textColor = .textColor
            biddingStatusLabel.textColor = .textColor

            biddingImageView.isHidden = true
        }
        
        minLabel.text = "min"
        minValue.text = with.minimumBid
        favoriteButton.setImage(with.isFavourite ?? false ? UIImage(named: "heart"):UIImage(named: "heart-add-line") , for: .normal)
        heartView.backgroundColor = with.isFavourite ?? false ? .Bronze_500 : .lightGray
        priceLabel.text = with.price
        titleLabel.text = with.name
        auctionsCountLabel.text = "\(with.bidsCount ?? 0)"
        guard let date = with.endAt?.getDate() else {return}
        
        endInLabel.text = "\(date.day+"d") \(date.hour+"h") \(date.minute+"m")"
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
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        onTapFavoriteButton?()
    }
}
