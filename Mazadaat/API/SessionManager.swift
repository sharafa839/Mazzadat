//
//  View.swift
//  Naseem
//
//  Created by Dev Anas on 3/17/19.
//  Copyright � 2019 Dev Anas. All rights reserved.
//

import UIKit


class SessionManager : NSObject {
    class var sharedManger : SessionManager {
        struct Static {
            static let instance = SessionManager()
        }
        return Static.instance
    }
    
    
    let drawerWidthPercentage : CGFloat = 6/8
    let screenReminderWidthPercentage : CGFloat = 2/8
    let apiPath = "https://app.golden-auctions.com/"
    let imagePath = "https://app.golden-auctions.com/"
    let deviceId = UIDevice.current.identifierForVendor?.uuidString
    
//    class func currentLanguage() -> Language{
//        let langStr = Locale.current.languageCode
//        if  (langStr?.contains("ar"))!{
//            return Language.arabic
//        }else{
//            return Language.english
//        }
//    }
    
    
    var token : String!
    var isLogin : Bool = false
  
    
    class func saveSessionManger(){
        var dict : Dictionary<String , Any> = [:]
        dict["isLogin"] = SessionManager.sharedManger.isLogin
        dict["token"] = SessionManager.sharedManger.token
        
        UserDefaults.standard.set(dict, forKey: "SessionManager")
    }
    
    
    struct student {
        static let studentSelect = UserDefaults.standard.string(forKey: "studentName") ?? ""

    }
    class func loadSessionManager(){
        if let dict = UserDefaults.standard.dictionary(forKey: "SessionManager"){
            SessionManager.sharedManger.isLogin =  dict["isLogin"] as? Bool ?? false
            SessionManager.sharedManger.token =  dict["token"] as? String  ?? nil
           
            
        }
    }
    
    
    
    class func clearSession(){
        var dict : Dictionary<String , Any> = [:]
        dict["isLogin"] = false
        dict["token"]  = nil
        SessionManager.sharedManger.token = nil
        SessionManager.sharedManger.isLogin = false
        UserDefaults.standard.set(dict, forKey: "SessionManager")
    }
    
}





//enum Language{
//    case arabic,english
//}

