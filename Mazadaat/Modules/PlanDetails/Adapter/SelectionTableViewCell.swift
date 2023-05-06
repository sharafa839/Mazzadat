//
//  SelectionTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setRoundCorners(5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionImageView.isHidden = !selected
    }
    
    func configure(_ with:PaymentMethodCases) {
        
        titleLabel.text = with.title
    }
}

enum PaymentMethodCases:Int {
    case bankTransfer = 1 , cash = 2
    var title:String {
        switch self {
        case .bankTransfer: return "bankTransfer"
        case .cash:return "cash"
        }
    }
}


