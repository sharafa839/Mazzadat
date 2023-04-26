//
//  AuctionSortingTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionSortingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkImage.isHidden = !selected
    }
    
    func configure(_ with:SortingModel) {
        titleLabel.text = with.title
        
    }
}
