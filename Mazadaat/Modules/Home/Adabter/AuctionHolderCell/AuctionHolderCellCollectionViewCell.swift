//
//  AuctionHolderCellCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 09/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionHolderCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var auctionHolderTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var auctionHolderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

   private func setupUI() {
        containerView.drawBorder(raduis: 5, borderColor: .orange)
    }
    
    func setupAuctionHolder() {
        
    }
}
