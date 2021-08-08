//
//  AuctionsTableViewCell.swift
//  Mazadaat
//
//  Created by macbook on 10/20/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class AuctionsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var aucationNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var auctionsLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var auctionsCounterLabel: UILabel!
    
    @IBOutlet weak var auctionNumber: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    var releaseDate: Date?
    var countdownTimer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        img.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 4)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    func startTimer(endDate: String) {
        releaseDate  = endDate.toDateNew()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTime(label: self.dateLabel)
            
            RunLoop.current.add(self.countdownTimer, forMode: RunLoop.Mode.common)

        }
    }

    func updateTime(label: UILabel) {
        let currentDate = Date()
        let calendar = Calendar.current


        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate!)
        
        let secounds = "\(diffDateComponents.second ?? 0)"

        if secounds.contains("-"){
            label.text = "المزاد منتهي"

            return
        }
   
        label.text = "\(diffDateComponents.day ?? 0)ي \(diffDateComponents.hour ?? 0)س \(diffDateComponents.minute ?? 0)د \(diffDateComponents.second ?? 0)ث "

    }
    
}
