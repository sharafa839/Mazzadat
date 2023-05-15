//
//  EmptyAddDocumentTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class EmptyAddDocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var uploadPictureButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadPhotoLabel: UILabel!
    @IBOutlet weak var instrtuctionLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    var onTapButton:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI() 
    }

    
    private func setupUI() {
        containerView.setRoundCorners(5)
        uploadPictureButton.circle()
        uploadButton.setRoundCorners(20)
        uploadButton.setTitle(Localizations.uploadDocument.localize, for: .normal)
        instrtuctionLabel.text = "inJpegOrPNG".localize
        uploadPhotoLabel.text = "uploadImage".localize
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        onTapButton?()
    }
    
}
