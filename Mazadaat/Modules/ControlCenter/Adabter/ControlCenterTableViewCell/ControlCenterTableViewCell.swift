//
//  ControlCenterTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ControlCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setRoundCorners(0)
    }
    
    func configure(_ with:ControlCenter) {
        titleLabel.text = with.title
        if with.round == .bottom {
            containerView.roundCorners([.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 5)
        }else if with.round == .top {
            containerView.roundCorners([.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 5)
        }else {
            return
        }
    }
    
}
