//
//  AuthNetworkingProtocol.swift
//  Dana
//
//  Created by Sharaf on 20/05/2022.
//

import Foundation
protocol AuthNetworkingProtocol {
  func login(phone:String,password:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func register(phone:String,password:String,email:String,name:String,government:String,city:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func logout(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func changePassword(currentPassword:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func resetPassword(phone:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func verifyCodeWithNewPassword(code:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
}

extension AuthNetworkingProtocol {
  private var auth : AuthRepo {
    return AuthRepo()
  }
  
  func login(phone:String,password:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .login(password: password, phone: phone), completion: completion)
  }
  
  func register(phone:String,password:String,email:String,name:String,government:String,city:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .register(name: name, phone: phone, password: password, email: email, city: city, government: government), completion: completion)
  }
  
  func logout(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .logout, completion: completion)
  }
  
  func changePassword(currentPassword:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .changePassword(currentPassword: currentPassword, newPassword: newPassword), completion: completion)
  }
  
  func resetPassword(phone:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){
    auth.request(target: .resetPassword(phone: phone), completion: completion)
  }

  func verifyCodeWithNewPassword(code:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .verifyCodeWithNewPassword(code: code, newPassword: newPassword), completion: completion)
  }


}
