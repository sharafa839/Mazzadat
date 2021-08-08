//
//  RouteManager.swift
//  trainingProject
//
//  Created by Ahmed Alaloul on 2/24/18.
//  Copyright © 2018 Ahmed Alaloul. All rights reserved.
//

import UIKit
import SideMenu
class RouteManager: NSObject {
    static func showSideMenuVC (_ viewController : UIViewController) {
        
        
        if AppData.lang == "en"{
            
     
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuRightVC = storyboard.instantiateViewController(withIdentifier: "aa") as! UISideMenuNavigationController
            SideMenuManager.default.menuLeftNavigationController = menuRightVC
           
    //        menuRightVC.delegate = self
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuBlurEffectStyle = .light
            SideMenuManager.default.menuShadowColor = .black
            SideMenuManager.default.menuShadowOpacity = 20
            SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
            viewController.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            
        }else{
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuRightVC = storyboard.instantiateViewController(withIdentifier: "aa") as! UISideMenuNavigationController
            SideMenuManager.default.menuRightNavigationController = menuRightVC
           
    //        menuRightVC.delegate = self
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuBlurEffectStyle = .light
            SideMenuManager.default.menuShadowColor = .black
            SideMenuManager.default.menuShadowOpacity = 20
            SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
            viewController.present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
            
            
            
        }
    
        
        
    }
//    static func presentwithdataVC (_ viewController : UIViewController) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        viewController.present(vc, animated: true, completion: nil)
//    }
//    static func openwithdataVC (_ viewController : UINavigationController,username:String) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        vc.stri = username
//        viewController.pushViewController(vc, animated: true)
//    }
//        static func openwithoutdataVC (_ viewController : UINavigationController) {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//            viewController.pushViewController(vc, animated: true)
//
//        }
    
}
