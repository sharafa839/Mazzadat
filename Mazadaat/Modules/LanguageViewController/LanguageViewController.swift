//
//  LanguageViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 12/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var arabicSelectionImageView: UIImageView!
    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var arabicImage: UIImageView!
    @IBOutlet weak var englishView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    var selection :Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalize()
        setupUI()
    }

    private func setupUI() {
        arabicView.setRoundCorners(15)
        englishView.setRoundCorners(15)
        containerView.setRoundCorners(25)
        arabicSelectionImageView.isHidden = true
        selectionImage.isHidden = true

    }
    
    private func setupLocalize() {
        languageName.text = "english".localize
        arabicLabel.text = "arabic".localize
        saveButton.setTitle(Localizations.save.localize, for: .normal)
    }

    @IBAction func englishAction(_ sender: UIButton) {
        selection = LocalizationManager.shared.getLanguage() == .English ? nil : 2
        arabicSelectionImageView.isHidden = true
        selectionImage.isHidden = false
    }
    
    @IBAction func arabicAction(_ sender: Any) {
        selection = LocalizationManager.shared.getLanguage() == .Arabic ? nil : 1
        arabicSelectionImageView.isHidden = false
        selectionImage.isHidden = true
    }
    
    @IBAction func changeLanguageAction(_ sender: CustomButton) {
        guard let selection = selection else {
            dismiss(animated: true)
            return
        }
        if selection == 1 {
            LocalizationManager.shared.setLanguage(language: .Arabic)
        }else {
            LocalizationManager.shared.setLanguage(language: .English)

        }
    }
}
