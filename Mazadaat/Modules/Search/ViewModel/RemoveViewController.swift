//
//  RemoveViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 10/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class RemoveViewController: UIViewController {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel:RemoveViewModel
    init(viewModel:RemoveViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        containerView.setRoundCorners(20)
        cancelButton.drawBorder(raduis: 20, borderColor: .red)
        removeButton.setRoundCorners(20)
    }

    private func setupLocalize() {
        let type = viewModel.type
        switch type {
        case .unFavorite:
            titleLabel.text = ""
            descriptionLabel.text = ""
        case .removeNationalIdCard:
            titleLabel.text = ""
            descriptionLabel.text = ""
        case .removeLicense:
            titleLabel.text = ""
            descriptionLabel.text = ""
        }
        
        cancelButton.setTitle(Localizations.cancel.localize,for: .normal)
        removeButton.setTitle(Localizations.remove.localize,for: .normal)
    }
    
    

    
}

enum RemoveControllerCases {
    case unFavorite(id:String)
    
    case removeNationalIdCard(id:String,front:Bool?,back:Bool?)
    
    case removeLicense(id:String,front:Bool?,back:Bool?)
}
