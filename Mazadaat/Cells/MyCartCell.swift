//
//  MyCartCell.swift
//  Mazadaat
//
//  Created by macbook on 12/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MyCartCell: UITableViewCell {

    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stateTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var botomView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        botomView.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 15)
        img.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: 15)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
