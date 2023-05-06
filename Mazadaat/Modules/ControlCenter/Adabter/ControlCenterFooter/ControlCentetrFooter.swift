//
//  ControlCentetrFooter.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ControlCentetrFooter: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var onTapLogout:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    private func setupUI() {
        containerView.setRoundCorners(5)
        
        logoutButton.setTitle("logout", for: .normal)
    }
    
    @IBAction func logouttAction(_ sender: UIButton) {
        onTapLogout?()
    }
    
}
