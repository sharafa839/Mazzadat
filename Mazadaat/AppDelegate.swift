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
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate,UNUserNotificationCenterDelegate {

    private(set) lazy var coordinator = AppCoordinator()
    let gcmMessageIDKey = "gcm.Message_IDKey"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        IQKeyboardManager.shared.enable = true
        
       

        
        
        setupIAP()
        LocalizationManager.shared.setAppInnitLanguage()
        LocalizationManager.shared.delegate = self
        AppUtilities.changeRoot(root: SplashViewController(viewModel: SplashViewModel()))
        GMSPlacesClient.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")
        GMSServices.provideAPIKey("AIzaSyDR4OvW6PYXeKL5iq_TpEDbHzeq4SajVQc")
        
        
        
       
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }
        
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
    
    
    
    
     
        
        


}


extension AppDelegate:LocalizationManagerDelegate {
    func resetApp() {
      
        print("local")
        AppUtilities.changeRoot(root: UINavigationController(rootViewController: SplashViewController(viewModel: SplashViewModel())))
    }
    

}
extension AppDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {
 
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FirebaseMessaging.Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().isAutoInitEnabled = true

    }

}
