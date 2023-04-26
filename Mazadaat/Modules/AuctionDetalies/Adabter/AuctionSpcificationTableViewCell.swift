//
//  AuctionSpcificationTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionSpcificationTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(auction:AuctionDetail) {
        keyLabel.text = auction.name
        valueLabel.text = auction.value
    }
    
}
