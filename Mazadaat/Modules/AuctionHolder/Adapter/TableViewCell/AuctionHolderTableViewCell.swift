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
    
    var timer:TimerManagerr?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
       
        timer?.stopTimer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupLocalize()
        setupUI()
    }
    
    private func setupLocalize() {
        entryFeeLabel.text = "entryFee".localize
        
        auctionDaysLabel.text = "auctionDays".localize
    }
    
    private func setupUI() {
        containerDetailesView.floatView(raduis: 10, color: .Natural_200)
        auctionPlaceImageView.setRoundCorners(10)
        
        kindOfAuctionButton.setRoundCorners(10)
        countOfAuctionButton.setRoundCorners(10)
        
    }
    
    func configure(_ with:AuctionHolderPlacesUIModel) {
        kindOfAuctionButton.backgroundColor = with.backgroundColor
        kindOfAuctionButton.setTitleColor(with.titleColor, for: .normal)
    
        cityLabel.text = with.name
        kindOfAuctionButton.setTitle(with.type?.localize, for: .normal)
        countOfAuctionButton.backgroundColor = .white
        countOfAuctionButton.setTitle(with.auctionsCount, for: .normal)
        entryFeeValueLabel.text = "\(with.entryFee)"
        setupDate(with)
         let image = with.cover 
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
    
    private func setupDate(_ with:AuctionHolderPlacesUIModel) {
      

        let seconds = "\(with._startingDate?.second ?? 0)"

        if seconds.contains("-"){
            startinLabel.text = "endingIn".localize
            let secondsBetweenStartAndEndAuctionTime = "\(with._endingDate?.second ?? 0)"
            if secondsBetweenStartAndEndAuctionTime.contains("-") {
                startingInValueLabel.text = "expired".localize
                auctionDaysValueLabel.text = "expired".localize
            }else {
                auctionDaysValueLabel.text = "\(with._endingDate?.day ?? 0)" + "days".localize
                timerStart(endDate:with.endAuctionTime )
            }
          

        }else {
            startinLabel.text = "startingIn".localize
            auctionDaysValueLabel.text = "\(with._endingDate?.day ?? 0)" + "days".localize

            timerStart(endDate: with.auctionTime )

        }
    }
    
    func timerStart(endDate:String) {
        timer = TimerManagerr(interval: 1, endDate: endDate, stopTimer: false) { (day, hour, minute, second, true) in
            self.startingInValueLabel.text = day + " " + "d".localize + " " + hour + "h".localize + " " + minute + " " + "m".localize + " " + second + " " + "s".localize
        }
        timer?.start()
    }
    
}

enum AuctionType:String {
    
    case online = "online"
    case attendance = "attendance"
    case hybrid =  "hybrid"
    var localize:String {
        switch self {
        case .online:
            return "online".localize
        case .attendance:
            return "attendance".localize
        case .hybrid:
            return "hybrid".localize
            
        }
    }
    
    var titleColor:UIColor {
        switch self {
        case .online:
            return .Bronze_500
        case .attendance:
            return .white
        case .hybrid:
            return .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self{
        case .online:
            return .white
        case .attendance:
            return .textColor
            
        case .hybrid:
            return .Bronze_500
        }
    }
}
