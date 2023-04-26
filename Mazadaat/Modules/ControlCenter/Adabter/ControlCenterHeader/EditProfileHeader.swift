//
//  EditProfileHeader.swift
//  Mazadaat
//
//  Created by Sharaf on 26/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class EditProfileHeader: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setupUI() {
        profileImageView.drawBorder(raduis: profileImageView.frame.height/2, borderColor: .white,borderWidth: 3)
        nameLabel.text = HelperK.getname()
        guard let url = URL(string: HelperK.getAvatar()) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        profileImageView.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
}
