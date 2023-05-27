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
    @IBOutlet weak var sarLabel: UILabel!
    @IBOutlet weak var biddingButtonView: UIView!
    @IBOutlet weak var biddingButton: UIButton!
    @IBOutlet weak var endingInLabel: UILabel!
    @IBOutlet weak var endingInValueLabel: UILabel!
    @IBOutlet weak var hightImage: UIImageView!
    @IBOutlet weak var nextBidLabel: UILabel!
    @IBOutlet weak var biddingValueLabel: UILabel!
    @IBOutlet weak var heighstValueLabel: UILabel!

    var lastBid = 0
    var initialPrice = 0
    var minimumBid = 0
    var total:Int {
        if lastBid == 0 {
            return initialPrice + minimumBid
        }else {
            return lastBid + minimumBid
        }
        
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
            nextBidLabel.text = "yourTheHeighstNow".localize
            biddingValueLabel.isHidden = true
            hightImage.isHidden = false
            biddingButtonView.isHidden = true
            biddingValueLabel.isHidden = true
            heighstValueLabel.isHidden = false
            heighstValueLabel.text = with.lastBid?.price ?? "" + Localizations.SAR.localize
        }else {
            heighstValueLabel.isHidden = true
            hightImage.isHidden = true
        initialPrice = Int(with.price  ?? "0") ?? 0
        lastBid = Int(with.lastBid?.price ?? "0") ?? 0
        minimumBid = Int(with.minimumBid ?? "0") ?? 0
            if lastBid == 0 {
                biddingValueLabel.text = "\(minimumBid + initialPrice )"
            }else {
                biddingValueLabel.text = "\(lastBid + minimumBid )"
            }
            endingInLabel.text = "endingIn".localize
        setupDate(with.endAt ?? "", with.startAt ?? "")
            nextBidLabel.text = "nextBidding".localize
            biddingButton.setTitle("bidNow".localize, for: .normal)
        }
        sarLabel.text =  Localizations.SAR.localize
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
            endingInValueLabel.text = "expired".localize

        }else {
            timerStart(endDate: end)

        }
    }
    
    func timerStart(endDate:String) {
        TimerManagerr(interval: 1, endDate: endDate, stopTimer: false) { (day, hour, minute, second, true) in
            self.endingInValueLabel.text =  "endingIn".localize + day + "d".localize + hour + "h".localize + minute + "m".localize + second + "s".localize
        }.start()
    }

    @IBAction func biddingButtonAction(_ sender: UIButton) {
        didTapBiddingButton?(total)
    }
    
}
