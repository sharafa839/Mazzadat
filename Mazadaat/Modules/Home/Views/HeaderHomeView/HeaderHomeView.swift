//
//  HeaderHomeView.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class HeaderHomeView: UIView {

  
    //MARK: - IBOutlets
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var gearButton: UIButton!
    @IBOutlet weak var settingView: UIView!
    //MARK: - Properties
    
    //MARK: - Init
    var onTapNotification:(()->Void)?
    var onTapSearch:(()->Void)?
    var onTapSetting:(()->Void)?
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLocalize()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    
    
    //MARK: - Methods
    func configure() {
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
    
    private func setupLocalize() {
        welcomeLabel.text = "welcomeBack"
    }
    
    func setupUI(view:ViewType) {
        if view == .profile {
            setupViewInProfile()
        }else{
            settingView.isHidden = true
            searchView.circle()
            notificationView.circle()
            imageContainerView.drawBorder(raduis: imageContainerView.frame.height / 2, borderColor: .white)
            imageContainerView.layer.borderWidth = 1
            notificationView.drawBorder(raduis: notificationView.frame.height / 2, borderColor: .clear)
            searchView.drawBorder(raduis: searchView.frame.height / 2, borderColor: .clear)
        }
    }
    
    private func setupViewInProfile() {
        settingView.setRoundCorners(15)
        searchView.isHidden = true
        notificationView.isHidden = true
        nameLabel.textColor = .white
        welcomeLabel.textColor = .white
        nameLabel.font = .Archivo(18, weight: .Bold)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        onTapSearch?()
    }
    @IBAction func notificationButtonAction(_ sender: UIButton) {
        onTapNotification?()
    }
    @IBAction func gearButtonAction(_ sender: UIButton) {
        onTapSetting?()
    }
    
    @IBAction func arrowButtonAction(_ sender: UIButton) {
        onTapSetting?()
    }
}
