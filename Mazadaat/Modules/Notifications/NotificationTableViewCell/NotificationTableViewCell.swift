//
//  NotificationTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 11/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    private func setupUI() {
        imageContainerView.setRoundCorners(10)
    }
    
    func configure(_ with:NotificationsModel) {
        titleLabel.text = with.title
        messageLabel.text = with.message
        let createdAt = with.createdAt
        let date = createdAt?.toDateNew(withFormat: "yyyy-MM-dd HH:mm a")
        dateLabel.text = date?.timeAgoDisplay()
    }
    
    
    
}
