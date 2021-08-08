//
//  docCell.swift
//  Mazadaat
//
//  Created by macbook on 11/7/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class docCell: UITableViewCell {

    @IBOutlet weak var editDoc: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var docImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
