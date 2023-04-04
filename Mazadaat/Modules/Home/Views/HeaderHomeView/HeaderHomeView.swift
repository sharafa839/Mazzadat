//
//  HeaderHomeView.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

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
    
    //MARK: - Properties
    
    //MARK: - Init
    var onTapNotification:(()->Void)?
    var onTapSearch:(()->Void)?
    //MARK: - LifeCycle
    
    init() {
        <#statements#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    func configure() {
        
    }
    
    private func setupUI() {
        searchView.circle()
        notificationView.circle()
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        onTapSearch?()
    }
    @IBAction func notificationButtonAction(_ sender: UIButton) {
        onTapNotification?()
    }
    
}
