//
//  FillAddDocumentTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher

class FillAddDocumentTableViewCell: UITableViewCell {

 
    @IBOutlet weak var deleteButton: UIButton!

    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var onTapDelete:(()->Void)?
    var onTapChange:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupLocalize()
    }

    private func setupUI() {
        containerView.setRoundCorners(5)
        changeButton.setRoundCorners(5)
        deleteButton.setRoundCorners(5)
        documentImageView.setRoundCorners(5)
        
    }
    
    private func setupLocalize() {
        changeButton.setTitle(Localizations.change.localize, for: .normal)
        deleteButton.setTitle(Localizations.delete.localize, for: .normal)
    }
    
    
    func configure(_ document:String) {
        
        guard let url = URL(string: document) else {return
            documentImageView.image = UIImage(data: Data(base64Encoded: document) ?? Data())
        }
        let placeholderImage = UIImage(data: Data(base64Encoded: document) ?? Data()) ?? UIImage()
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
