//
//  AuctionDetailesView.swift
//  Mazadaat
//
//  Created by Sharaf on 15/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionDetailesView: UIView {

    @IBOutlet weak var numberOfBidLabel: UILabel!
    @IBOutlet weak var biddingCounterLabel: UILabel!
    @IBOutlet weak var containerBidView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var auctionPlaceLabel: UILabel!
    @IBOutlet weak var auctionName: UILabel!
    @IBOutlet weak var auctionTypeLabel: UILabel!
    //MARK: - IBOutlets
    
    func configure(_ with:AuctionDetailsModel,type:String) {
        descriptionValueLabel.text = with.description
        auctionPlaceLabel.text = "map".localize
        auctionName.text = with.name
        descriptionLabel.text = with.description
        auctionTypeLabel.text = type
        biddingCounterLabel.text = "\(with.bidsCount ?? 0)"
        numberOfBidLabel.text = "numberOfBids".localize
        containerBidView.isHidden = !((with.bidsCount ?? 0) > 0)
        auctionPlaceLabel.text = with.city?.name
        auctionTypeLabel.text = with.type
        layoutIfNeeded()
    }
    
    private func setupUI() {
        containerView.setRoundCorners(10)
        containerBidView.drawBorder(raduis: 10, borderColor: .Bronze_500)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
}
