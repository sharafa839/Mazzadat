//
//  PersonalInformationTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PersonalInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.setRoundCorners(10)
    }
    
    func configure(_ with:PersonalInformation) {
        titleLabel.text = with.title
        valueLabel.text = with.value
        successImageView.isHidden = !with.image
    }
}
