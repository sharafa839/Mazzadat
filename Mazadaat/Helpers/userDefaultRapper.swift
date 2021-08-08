//
//  userDefaultRapper.swift
//  PunkPandaApp
//
//  Created by macbook on 9/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}


struct AppData {
    //@Storage(key: "username_key", defaultValue: "")
    //static var username: String

    @Storage(key: "enable_auto_login_key", defaultValue: false)
    static var enableAutoLogin: Bool
    
    @Storage(key: "LogClick", defaultValue: false)
    static var logClick: Bool
    
    @Storage(key: "firstTime", defaultValue: false)
    static var firstLog: Bool
    
    @Storage(key: "status", defaultValue: false)
    static var isLogin: Bool
    
    @Storage(key: "lang", defaultValue: "ar")
    static var lang: String
    @Storage(key: "nameUser", defaultValue: "")
    static var username: String
    
    @Storage(key: "phoneNumber", defaultValue: "")
    static var phoneNumber: String
    
    
    @Storage(key: "showPayment", defaultValue: "")
    static var showPayment: String
    
    @Storage(key: "userID", defaultValue: 0)
     static var userId: Int
     
    @Storage(key: "LogPassword", defaultValue: "")
    static var password: String
   
    
    @Storage(key: "email", defaultValue: "")
    static var email: String
    
    @Storage(key: "firstLogin", defaultValue: true)
    static var firstLogin: Bool
    
    @Storage(key: "userImg", defaultValue: "")
       static var userImg: String
    
    @Storage(key: "givenName", defaultValue: "")
    static var givenName: String
    
    @Storage(key: "token", defaultValue: "")
    static var userToken: String
    
    
    @Storage(key: "fcmToken", defaultValue: "")
    static var fcmToken: String
    
    
    @Storage(key: "isVerfiyEmail", defaultValue: false)
    static var isVeerfiyEmail: Bool

}

//MARK: UserDefaults Store Data
enum UserDefaultsKeys : String {
    case token
    case userId
    case userName
    case password
    
}


extension UserDefaults{
    func setUserName(value: String){
        set(value, forKey: UserDefaultsKeys.userName.rawValue)
    }
    
    func getUserName() -> String{
        return string(forKey: UserDefaultsKeys.userName.rawValue) ?? ""
    }
    
    func setUserId(value: Int){
        set(value, forKey: UserDefaultsKeys.userId.rawValue)
    }
    
    func getUserID(value: Int){
        set(value, forKey: UserDefaultsKeys.userId.rawValue)
    }
    
    func setPassowrd(value: String){
        set(value, forKey: UserDefaultsKeys.password.rawValue)
    }
    
    
    func getPassword() -> String{
        return string(forKey: UserDefaultsKeys.password.rawValue) ?? ""
    }
    
}

// This ecteniton convert string to TimeInterval
extension String {
    func convertToTimeInterval() -> TimeInterval {
        guard self != "" else {
            return 0
        }
        
        var interval:Double = 0
        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
}


