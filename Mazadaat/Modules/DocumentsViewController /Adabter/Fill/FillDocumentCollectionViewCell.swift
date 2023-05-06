//
//  FillDocumentCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class FillDocumentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var onTapDelete:(()->Void)?
    var onTapChange:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.setRoundCorners(5)
        changeButton.setRoundCorners(20)
        deleteButton.setRoundCorners(20)
        documentImageView.setRoundCorners(5)
        
    }
    
    
    func configure(_ document:UploadDocuments) {
        documentNameLabel.text = document.documentType?.name
        guard let front = document.frontFace else {
            guard let image = document.backFace else {return}
            guard let url = URL(string: image) else {return}
            let placeholderImage = UIImage(named: "AppIcon")!
            let processor = DefaultImageProcessor.default
            documentImageView.kf.setImage(
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
            return
        }
        
        guard let url = URL(string: front) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        documentImageView.kf.setImage(
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
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        onTapDelete?()
    }
    
    @IBAction func changeButtonAction(_ sender: UIButton) {
        onTapChange?()
    }
}