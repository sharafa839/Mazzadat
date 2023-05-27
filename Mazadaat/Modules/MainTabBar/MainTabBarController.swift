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
        setupAppearance()
        setControllers()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        print("Tab bar ")
    }

    private func setControllers() {
        let homeViewModel = HomeViewModel()
       let homeViewController = HomeViewController(viewModel: homeViewModel)
        
       let profileViewController = ProfileViewController(viewModel: ProfileViewModel())
        let askGoldenBell = AskGoldenBellViewController(viewModel: AskGoldenBellViewModel())
        let auctionSection = AuctionsSectionViewController(viewModel: AuctionSectionViewModel())
        let rawViewControllers: [UIViewController] = [homeViewController,askGoldenBell,auctionSection,
                                                          profileViewController]
        
        let navigationViewControllers = rawViewControllers.map(UINavigationController.init)
        setupNavigationAppearance(navigationViewControllers)
        setViewControllers(navigationViewControllers, animated: true)
    }
    
    private func setupAppearance() {
        UITabBar.appearance().barTintColor = .textColor
        UITabBar.appearance().tintColor = .Bronze_500
        UITabBar.appearance().unselectedItemTintColor = .white
        guard #available(iOS 13.0, *) else { return }
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) { tabBar.scrollEdgeAppearance = tabBar.standardAppearance }
    }
    
    private func setupNavigationAppearance(_ navigationControllers: [UINavigationController]) {
        let font = UIFont.Cairo(12)
        
        let titles: [String] = [Localizations.home.localize,
                                Localizations.askGoldenBell.localize,
                                Localizations.auctions.localize,
                                Localizations.myProfile.localize]
        
        let unselectedImageNames = ["home-5-fill",
                                    "question-mark",
                                    "auction-line-2",
                                    "user-smile-line"
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

