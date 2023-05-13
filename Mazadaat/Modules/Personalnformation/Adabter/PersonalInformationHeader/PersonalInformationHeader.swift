//
//  PersonalInformationHeader.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher

class PersonalInformationHeader: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var personalImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    var onTapEdit:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        imageContainerView.circle()
        personalImageView.circle()
        editButton.setTitle("edit".localize, for: .normal)
        guard let url = URL(string: HelperK.getAvatar()) else {return}
        let placeholderImage = UIImage(named: HelperK.getAvatar()) ?? UIImage(named: "AppIcon")
        let processor = DefaultImageProcessor.default
        personalImageView.kf.setImage(
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
    @IBAction func editButtonAction(_ sender: UIButton) {
        onTapEdit?()
    }
    
}
