//
//  Coordinator.swift
//  Mazadaat
//
//  Created by Sharaf on 30/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
class AppCoordinator {
    
    // MARK: - Properties
    
    private(set) var window: UIWindow
    
    var rootViewController: UIViewController? {
        window.rootViewController
    }
    
    var presentedViewController: UIViewController? {
        rootViewController?.presentedViewController
    }
    
    var topMostController: UIViewController? {
        guard let rootViewController = rootViewController else { return nil }
        return getTopViewController(rootViewController)
    }
    
    // MARK: - init
    
    init(_ window: UIWindow? = nil) {
        self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Methods
    
    func setRoot(_ viewController: UIViewController) {
        appDelegate.configureIQKeyboardManager()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func launchFirstScreen() {
        setRoot(SplashViewController())
    }
    
  
    
    func presentOnRoot(_ viewController: UIViewController) {
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func getTopViewController(_ current: UIViewController) -> UIViewController {
        if let presentedController = current.presentedViewController {
            return getTopViewController(presentedController)
        }else if let pushedController = current.navigationController?.topViewController {
            return getTopViewController(pushedController)
        }else {
            return current
        }
    }
}
