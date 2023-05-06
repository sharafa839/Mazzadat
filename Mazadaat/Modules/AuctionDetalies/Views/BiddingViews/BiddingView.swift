//
//  BiddingView.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class BiddingView: UIView {

   //MARK: - IBOutlets
    @IBOutlet weak var biddingButtonView: UIView!
    @IBOutlet weak var biddingButton: UIButton!
    @IBOutlet weak var endingInLabel: UILabel!
    @IBOutlet weak var endingInValueLabel: UILabel!
    @IBOutlet weak var hightImage: UIImageView!
    @IBOutlet weak var nextBidLabel: UILabel!
    @IBOutlet weak var biddingValueLabel: UILabel!
    @IBOutlet weak var heighstValueLabel: UILabel!

    var nextBid = 0
    var initialPrice = 0
    var total:Int {
        return nextBid + initialPrice
    }
    var didTapBiddingButton:((_:Int)->Void)?
    //MARK: - Init
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    private func setupUI() {
        biddingButtonView.setRoundCorners(20)
    }
    
    func configure(_ with:AuctionDetailsModel,didBid:Bool) {
        if didBid {
            nextBidLabel.text = "yourTheHeighstOne"
            biddingValueLabel.isHidden = true
            hightImage.isHidden = false
            biddingButtonView.isHidden = true
            biddingValueLabel.isHidden = true
            heighstValueLabel.isHidden = false
            heighstValueLabel.text = with.lastBid?.price ?? "" + "SAR"
        }else {
            heighstValueLabel.isHidden = true
            hightImage.isHidden = true
        initialPrice = Int(with.price  ?? "0") ?? 0
        nextBid = Int(with.lastBid?.price ?? "0") ?? 0
        biddingValueLabel.text = "\(nextBid + initialPrice )"
        endingInLabel.text = "endingIn"
        setupDate(with.endAt ?? "", with.startAt ?? "")
        nextBidLabel.text = "nextBidding"
        biddingButton.setTitle("bidNow", for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    private func setupDate(_ end:String,_ start:String) {
         let startedAt = Date()
        guard let endAt = end.toDateNew() else {return}
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: startedAt, to: endAt)
        
        let seconds = "\(diffDateComponents.second ?? 0)"

        if seconds.contains("-"){
            endingInValueLabel.text = "expired"

        }else {
            endingInValueLabel.text = "\(diffDateComponents.day ?? 0)d \(diffDateComponents.hour ?? 0)h \(diffDateComponents.minute ?? 0) m"

        }
    }

    @IBAction func biddingButtonAction(_ sender: UIButton) {
        didTapBiddingButton?(total)
    }
    
}
