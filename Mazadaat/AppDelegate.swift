//
//  AppDelegate.swift
//  Mazadaat
//
//  Created by macbook on 10/11/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import SwiftyStoreKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private(set) lazy var coordinator = AppCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
       // application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)

        IQKeyboardManager.shared.enable = true
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)

        UNUserNotificationCenter.current().delegate = self

        setupIAP()
        LocalizationManager.shared.setAppInnitLanguage()
        LocalizationManager.shared.delegate = self
        
        GMSPlacesClient.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")
        GMSServices.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")
        
        if AppData.lang == "en"{
            changeLanguage(lang: "en")
        L102Localizer.DoTheMagic()
        }else{
            changeLanguage(lang: "en")
            L102Localizer.DoTheMagic()
        }
        coordinator.setRoot(SplashViewController(viewModel:SplashViewModel()))
        
        
        configureNotifications(application)
        connectToFcm()

        // Override point for customization after application launch.
        return true
    }
    
    func configureIQKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .default
        IQKeyboardManager.shared.toolbarTintColor = .Bronze_500
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
    }
    
    func setupIAP() {

            SwiftyStoreKit.completeTransactions(atomically: true) { purchases in

                for purchase in purchases {
                    switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        let downloads = purchase.transaction.downloads
                        if !downloads.isEmpty {
                            SwiftyStoreKit.start(downloads)
                        } else if purchase.needsFinishTransaction {
                            // Deliver content from server, then:
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                        print("\(purchase.transaction.transactionState.debugDescription): \(purchase.productId)")
                    case .failed, .purchasing, .deferred:
                        break // do nothing
                    @unknown default:
                        break // do nothing
                    }
                }
            }
            
            SwiftyStoreKit.updatedDownloadsHandler = { downloads in

                // contentURL is not nil if downloadState == .finished
                let contentURLs = downloads.compactMap { $0.contentURL }
                if contentURLs.count == downloads.count {
                    print("Saving: \(contentURLs)")
                    SwiftyStoreKit.finishTransaction(downloads[0].transaction)
                }
            }
        }
    
    func changeLanguage(lang:String){
         if lang.hasPrefix("en") {
             L102Language.setAppleLAnguageTo(lang: "en")
             UIView.appearance().semanticContentAttribute = .forceLeftToRight
             
         } else {
             L102Language.setAppleLAnguageTo(lang: "ar")
             UIView.appearance().semanticContentAttribute = .forceRightToLeft
             
         }
     }
    
    
    
        private func configureNotifications(_ application: UIApplication){
            if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self
                
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
            application.registerForRemoteNotifications()
        }
        
        func connectToFcm() {
            
    //        Messaging.messaging().shouldEstablishDirectChannel = true
            Messaging.messaging().delegate = self
            registerForPushNotification()
            
            
        }
        
        

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    //}


}


extension AppDelegate:LocalizationManagerDelegate {
    func resetApp() {
      
        print("local")
        if HelperK.checkFirstTime() == true{
            
            if HelperK.checkUserToken() == true{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main")
                coordinator.setRoot(vc)
        let option : UIView.AnimationOptions = .transitionCrossDissolve
        let duration : TimeInterval = 0.3
                UIView.transition(with: vc.view, duration: duration, options: option, animations: nil, completion: nil)
                
                }else{
                    let login = LoginViewController(viewModel: LoginViewModel())
                    let vc = UINavigationController(rootViewController: login)
                    coordinator.setRoot(vc)
                    let option : UIView.AnimationOptions = .transitionCrossDissolve
                    let duration : TimeInterval = 0.3
                    UIView.transition(with:vc.view , duration: duration, options: option, animations: nil, completion: nil)
                }}else{
                
                    let onBoarding = OnBoardingViewController()
                    let vc = UINavigationController(rootViewController: onBoarding)
                    coordinator.setRoot(vc)
                let option : UIView.AnimationOptions = .transitionCrossDissolve
                let duration : TimeInterval = 0.3
                    UIView.transition(with: vc.view, duration: duration, options: option, animations: nil, completion: nil)
            }
        
    }
    

}
