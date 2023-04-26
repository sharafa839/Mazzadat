//
//  MainTabBarController.swift
//  Mazadaat
//
//  Created by Sharaf on 26/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setControllers() {
        let homeViewModel = HomeViewModel()
       let homeViewController = HomeViewController(viewModel: homeViewModel)
        
       let profileViewController = ProfileViewController(viewModel: ProfileViewModel())
        let rawViewControllers: [UIViewController] = [homeViewController,
                                                          profileViewController]
        
        let navigationViewControllers = rawViewControllers.map(UINavigationController.init)
        setupNavigationAppearance(navigationViewControllers)
        setViewControllers(navigationViewControllers, animated: true)
    }
    
    private func setupNavigationAppearance(_ navigationControllers: [UINavigationController]) {
        let font = UIFont.Archivo(12, weight: .Bold)
        
        let titles: [String] = ["home",
                                "askGoldenBell",
                                "auctions",
                                "profile"]
        
        let unselectedImageNames = ["unselected-home-icon",
                                    "unselected-myorders",
                                    "unselected-cart",
                                    "unselectedDeals"
                                    ]
        let selectedImageNames = ["selected-home-icon",
                                  "selected-myorders",
                                  "selected-cart",
                                  "selected-deals"]
        
        navigationControllers.enumerated().forEach({ index, navigationController in
            let item = UITabBarItem(title: titles[index],
                                    image: UIImage(named: unselectedImageNames[index]),
                                    selectedImage: UIImage(named: selectedImageNames[index]))
            navigationController.tabBarItem = item
            navigationController.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
            navigationController.navigationBar.tintColor = .textColor
        })
    }
}


class TabBarViewController: UIViewController {
    var updateCartCount: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartCount?()
        super.viewWillAppear(animated)
    }
}
