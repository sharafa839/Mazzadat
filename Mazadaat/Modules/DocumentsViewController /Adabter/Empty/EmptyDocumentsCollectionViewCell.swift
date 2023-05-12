//
//  EmptyDocumentsCollectionViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class EmptyDocumentsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var documentIImageView: UIImageView!
    var onTapAdd:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    private func setupUI() {
        addView.setRoundCorners(20)
        addButton.setRoundCorners(20)
        containerView.setRoundCorners(5)
        addLabel.text = Localizations.add.localize
    }
    
    func configure(_ document:UploadDocuments) {
        documentLabel.text = document.documentType?.name
        guard let front = document.documentType?.image else {
                
                return
                
            }
            guard let url = URL(string: front) else {return}
            let placeholderImage = UIImage(named: "AppIcon")!
            let processor = DefaultImageProcessor.default
            documentIImageView.kf.setImage(
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
        

    @IBAction func addButtonAction(_ sender: UIButton) {
        onTapAdd?()
    }
}
