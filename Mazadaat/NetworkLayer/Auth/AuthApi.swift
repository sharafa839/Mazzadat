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
    case resetPassword(phone:String)
    case update(name:String,phone:String,email:String)
    case me
    case updateProfileImage(images:[MultiPartItem])
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
            return .requestParameters(parameters: ["currentPassword":currentPassword,"newPassword":newPassword], encoding: JSONEncoding.default)
        case .resetPassword(let phone):
            return .requestParameters(parameters: ["phone":phone], encoding: JSONEncoding.default)
        case .update(name: let name, phone: let phone, email: let email):
            return .requestParameters(parameters: ["name":name,"email":email,"mobile":phone], encoding: JSONEncoding.default)
        case .me:
            return .requestPlain
        case .updateProfileImage(let images):
            let imageName = "img-\(CACurrentMediaTime()).png"
            var multipart: [MultipartFormData] = []
            
            
            let multipartImages = images.map { image in
                MultipartFormData(provider: .data(image.data), name: image.keyName,
                                  fileName: image.fileName, mimeType: image.mimeType)
            }
            
            multipart.append(contentsOf: multipartImages)
            return .uploadMultipart(multipart)
        }
    }
    
}


struct MultiPartItem : Codable {
    var data: Data
    var fileName, mimeType, keyName: String
}