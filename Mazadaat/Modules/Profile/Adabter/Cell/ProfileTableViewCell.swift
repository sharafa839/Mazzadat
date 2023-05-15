//
//  ProfileTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.setRoundCorners(10)
    }
    
    func configure(_ with:ProfileModel) {
        titleLabel.text = with.title
        subTitleLabel.text = with.subTitle
        
    }
}
