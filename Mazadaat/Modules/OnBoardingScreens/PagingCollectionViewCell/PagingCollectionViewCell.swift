//
//  PagingCollectionViewCell.swift
//  Nashmi-Courier
//
//  Created by Shgardi on 01/08/2022.
//  Copyright © 2022 Mnasat. All rights reserved.
//

import UIKit

class PagingCollectionViewCell: UICollectionViewCell {
//MARK: - IBOutlets
    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    func selected() {
       // currentView.circle()
    }

}
