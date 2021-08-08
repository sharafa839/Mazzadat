//
//  AppDelegate+FCM.swift
//  ZYOU
//
//  Created by moumen isawe on 07/11/2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UserNotifications
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging




extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       
        print("UNNotificationResponse", response.notification.request.content.userInfo)

              let dict = response.notification.request.content.userInfo as! [String: Any]        
        

                  NotificationCenter.default.post(name: Notification.Name("recivedNoti"), object: dict)
        
        
        

    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo) // the payload that is attached to the push notification
        // you can customize the notification presentation options. Below code will show notification banner as well as play a sound. If you want to add a badge too, add .badge in the array.
        completionHandler([.alert,.sound])
    }

//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert,.badge,.sound])
//        
//        completionHandler(.alert)
//
//        
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        print("APN recieved")
          // print(userInfo)
          
          let state = application.applicationState
          switch state {
              
          case .inactive:
              print("Inactive")
              
          case .background:
              print("Background")
              // update badge count here
              application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
              
          case .active:
              print("Active")

          }
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    /// Register for push notifications
    func registerForPushNotification(){
        
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
//      Messaging.messaging().subscribe(toTopic: topic) { error in
//          print("Subscribed to \(topic)")
//
//        }
    }
}


extension AppDelegate: MessagingDelegate {
  
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        print("Fcmtoken",fcmToken)
        AppData.fcmToken = fcmToken ?? ""
//            Keychain.system.setSecret(fcmToken, forKey: "fcmToken")
    }
}
