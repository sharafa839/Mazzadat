//
//  HeaderView.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    //MARK: - IBoutlets
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Init
    var onTapNotification:(()->Void)?
    var onTapSearch:(()->Void)?
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    
    
    //MARK: - Methods
    func configure(_ with :ViewType) {
        switch with {
        case .profile:
            setupProfile()
        case .askGoldenBell:
            setupAskGoldenBell()
        default :return
        }

    }
    
    private func setupProfile() {
        searchButton.isHidden = true
        titleLabel.text = "profile"
        self.backgroundColor = .Bronze_500

    }
    
    private func setupAskGoldenBell() {
        titleLabel.font = .Archivo(28, weight: .Bold)
        titleLabel.text = "askGoldenBell"
        self.backgroundColor = .Bronze_500

    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        onTapSearch?()
    }
    @IBAction func notificationButtonAction(_ sender: UIButton) {
        onTapNotification?()
    }
    
}

enum ViewType {
    case profile
    case askGoldenBell
    case home
}
