//
//  AuctionOwnerView.swift
//  Mazadaat
//
//  Created by Sharaf on 15/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionOwnerView: UIView {
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var trustedImageView: UIImageView!
    @IBOutlet weak var auctionOwnerLabel: UILabel!
    @IBOutlet weak var trustedLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var properteisLabel: UILabel!
    @IBOutlet weak var chatWithOwnerButton: UIButton!
    
    //MARK: - Properties
    var didTapChatButton:(()->Void)?
    //MARK: - Init
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        containerView.setRoundCorners(10)
        ownerImageView.setRoundCorners(10)
    }
    
    private func configure(_ with:AuctionDetailsModel) {
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }

    @IBAction func onTapPrivateChatViewController(_ sender: Any) {
        didTapChatButton?()
        
    }
}
