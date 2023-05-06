//
//  SplashViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 28/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController, SwiftyGifDelegate {

    @IBOutlet weak var splashImage: UIImageView!
    var viewModel:SplashViewModel
    
    init(viewModel:SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        splashImage.delegate = self
        playGif()
    }
    
    func gifDidStop(sender: UIImageView) {
        viewModel.getCore()
    }
    
    func playGif() {
        guard let gif = try? UIImage(gifName: "Splash Ui O-w.gif") else { return }
        splashImage.startAnimatingGif()
        splashImage.setGifImage(gif, loopCount: 1)
    }

    private func disConnect() {
        guard let gif = try? UIImage(gifName: "Splash Ui O-w.gif") else { return }
        splashImage.setGifImage(gif, loopCount: 1)
        splashImage.stopAnimatingGif()
       
    }
    
    private func setupViewModelObserver() {
        viewModel.onSuccess.subscribe { [weak self] route in
            self?.navigateToNewRoot(route: route.element ?? .login)
        }.disposed(by: viewModel.disposeBag)
        viewModel.onError.subscribe {  error in
          guard let errorDescription = error.element else {return}
          HelperK.showError(title: errorDescription, subtitle: "")
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func navigateToNewRoot(route:Route) {
        switch route {
        case .home:
           let tabBarViewController = MainTabBarController()
            appDelegate.coordinator.setRoot(tabBarViewController)

        case .login:
            appDelegate.coordinator.setRoot(UINavigationController(rootViewController: LoginViewController(viewModel: LoginViewModel())))

        case .onBoarding:
            appDelegate.coordinator.setRoot(UINavigationController(rootViewController: OnBoardingViewController()))

        }
       
    }
   

}

