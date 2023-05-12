//
//  ProfileHeaderTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var addRequestLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var didTapRequestAction:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    private func setupUI() {
        containerView.setRoundCorners(10)
        addRequestLabel.text = Localizations.newAuctionRequest.localize
    }
    
    @IBAction func addRequestAction(_ sender: UIButton) {
        didTapRequestAction?()
        
    }
    
}
