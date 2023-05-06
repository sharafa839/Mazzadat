//
//  TicketTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 01/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var refrenceIdLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var ticketImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
