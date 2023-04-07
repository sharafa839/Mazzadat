//
//  AuthApi.swift
//  Dana
//
//  Created by Sharaf on 20/05/2022.
//

import Foundation
import Moya
enum AuthApiServices {
    case login(password:String,phone:String)
    case register(name:String,phone:String,password:String,email:String,city:String,government:String)
    case logout
    case changePassword(currentPassword:String,newPassword:String)
    case resetPassword(phone:String)
    case verifyCodeWithNewPassword(code:String,newPassword:String)
}

extension AuthApiServices:TargetType,BaseHeaders {
    
    var path: String {
        switch self {
        case .login:
            return EndPoints.Authentication.login.rawValue
        case .register:
            return EndPoints.Authentication.register.rawValue
        case .logout:
            return EndPoints.Authentication.logout.rawValue
        case .changePassword:
            return EndPoints.Authentication.changePassword.rawValue
        case .resetPassword:
            return EndPoints.Authentication.resetPassword.rawValue
        case .verifyCodeWithNewPassword:
            return EndPoints.Authentication.verifyCodeWithNewPassword.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logout: return .get
        default: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let password, let phone):
            return .requestParameters(parameters: ["phone":phone,"password":password], encoding: JSONEncoding.default)
        case .register(let name, let phone, let password, let email, let city, let government):
            return .requestParameters(parameters: ["phone":phone,"name":name,"password":password,"email":email,"city":city,"government":government], encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain
        case .changePassword(let currentPassword, let newPassword):
            return .requestParameters(parameters: ["currentPassword":currentPassword,"newPassword":newPassword], encoding: JSONEncoding.default)
        case .resetPassword(let phone):
            return .requestParameters(parameters: ["phone":phone], encoding: JSONEncoding.default)
        case .verifyCodeWithNewPassword(let code, let newPassword):
            return.requestParameters(parameters: ["code":code,"newPassword":newPassword], encoding: JSONEncoding.default)
        }
    }
    
}


