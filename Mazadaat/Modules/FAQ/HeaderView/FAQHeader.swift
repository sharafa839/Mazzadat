//
//  FAQHeader.swift
//  Mazadaat
//
//  Created by Sharaf on 19/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class FAQHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var sectionNameLabel: UILabel!
    var onTapHeader:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }


    private func setupUI() {
        counterView.circle()
        
    }
    
    func configure(ـ model:FAQModel) {
        countLabel.text = "\( model.faqs?.count ?? 0)"
        sectionNameLabel.text = model.name
       if model.isCollapseSection ?? true {
            containerView.roundCorners([.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 10)
        } else {
            containerView.setRoundCorners(10)
        }
    }
    
    @IBAction func onTapHeader(_ sender: UIButton) {
        onTapHeader?()
    }
    
}
