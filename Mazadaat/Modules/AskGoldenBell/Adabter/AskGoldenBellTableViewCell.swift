//
//  AskGoldenBellTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 27/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class AskGoldenBellTableViewCell: UITableViewCell {

    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var mapsView: UIView!
    
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var callView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continerView: UIView!
    
    var onTapMap:(()->Void)?
    var onTapCall:(()->Void)?
    var onTapChat:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupLocalize()
    }

    private func setupUI() {
        continerView.floatView(raduis: 5, color: .Natural_200)
       // continerView.setRoundCorners(5)
        auctionImageView.setRoundCorners(10)
        mapsView.drawBorder(raduis: 5, borderColor: .Bronze_500)
        callView.setRoundCorners(5)
        chatView.setRoundCorners(5)
        
    }
    
    private func setupLocalize() {
        mapLabel.text = "map".localize
        callLabel.text = Localizations.call.localize
        chatLabel.text = Localizations.chat.localize
    }
    
    func configure(_ with:AllAdvertisement) {
        titleLabel.text = with.name
        descriptionLabel.text = with.description
        guard let image = with.image else {return}
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        auctionImageView.kf.setImage(
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
    
    @IBAction func chatButtonAction(_ sender: UIButton) {
        onTapChat?()
    }
    @IBAction func mapButtonAuction(_ sender: UIButton) {
        onTapMap?()
    }
    @IBAction func callButtonAction(_ sender: UIButton) {
        onTapCall?()
    }
    
}

extension UIView{
    func addShadow(cornerRadius: CGFloat, maskedCorners: CACornerMask, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
            self.layer.cornerRadius = cornerRadius
            self.layer.maskedCorners = maskedCorners
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOffset = offset
            self.layer.shadowOpacity = opacity
            self.layer.shadowRadius = shadowRadius
        }
}