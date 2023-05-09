//
//  AuthApi.swift
//  Dana
//
//  Created by Sharaf on 20/05/2022.
//

import Foundation
import Moya
import UIKit
enum AuthApiServices {
    case login(password:String,email:String)
    case register(name:String,phone:String,password:String,email:String)
    case logout
    case changePassword(currentPassword:String,newPassword:String)
    case resetPassword(phone:String,password:String,confirmPassword:String)
    case update(name:String,phone:String,email:String)
    case me
    case updateProfileImage(images:MultiPartItem)
    case  setupNotification(auctionAlert:Bool?,bidUpdates:Bool?,promotion:Bool?,auctionEndingSoon:Bool?)
}

extension AuthApiServices:TargetType,BaseApiHeadersProtocol {
    
    var path: String {
        switch self {
        case .login:
            return EndPoints.Auth.login.rawValue
        case .register:
            return EndPoints.Auth.register.rawValue
        case .logout:
            return EndPoints.Auth.logOut.rawValue
        case .changePassword:
            return EndPoints.Auth.changePassword.rawValue
        case .resetPassword:
            return EndPoints.Auth.resetPassword.rawValue
        case .me :
            return EndPoints.Auth.me.rawValue
        case .update,.updateProfileImage:
            return EndPoints.Auth.update.rawValue
            
        case .setupNotification(auctionAlert: let auctionAlert, bidUpdates: let bidUpdates, promotion: let promotion, auctionEndingSoon: let auctionEndingSoon):
            return  EndPoints.Auth.notificationSetting.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .me: return .get
        default: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let password, let email):
            return .requestParameters(parameters: ["email":email,"password":password,"device_token": AppData.fcmToken,"device_type":"iOS"], encoding: JSONEncoding.default)
        case .register(let name, let phone, let password, let email):
            return .requestParameters(parameters: ["email" : email,"password":password,"name":name,"mobile":phone,"app_locale":AppData.lang,"device_token": AppData.fcmToken,"device_type":"iOS"], encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain
        case .changePassword(let currentPassword, let newPassword):
            return .requestParameters(parameters: ["old_password":currentPassword,"password":newPassword], encoding: JSONEncoding.default)
        case .resetPassword(let phone,let password,let ConfirmPassword):
            return .requestParameters(parameters: ["mobile_number":phone,"password":password,"password_confirmation":ConfirmPassword], encoding: JSONEncoding.default)
        case .update(name: let name, phone: let phone, email: let email):
            return .requestParameters(parameters: ["name":name,"email":email,"mobile":phone], encoding: JSONEncoding.default)
        case .me:
            return .requestPlain
        case .updateProfileImage(let images):
            let imageName = "img-\(CACurrentMediaTime()).png"
            let multipart = [MultipartFormData(provider: .data(images.data), name: images.keyName, fileName: images.fileName, mimeType: images.mimeType)]
            return .uploadMultipart(multipart)
        case .setupNotification( let auctionAlert, let bidUpdates, let promotion, let auctionEndingSoon):
            var parameters : [String:Any] = [:]
            if let auctionAlert = auctionAlert {
                parameters["auction_alerts"] = auctionAlert
            }
            if let bidUpdates = bidUpdates {
                parameters["bid_updates"] = auctionAlert
            }
            if let promotion = promotion {
                parameters["promotions"] = auctionAlert
            }
            if let auctionEndingSoon = auctionEndingSoon {
                parameters["auction_ending_soon"] = auctionEndingSoon
            }
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
}


struct MultiPartItem : Codable {
    var data: Data
    var fileName, mimeType, keyName: String
}
