//
//  AuthNetworkingProtocol.swift
//  Dana
//
//  Created by Sharaf on 20/05/2022.
//

import Foundation
protocol AuthNetworkingProtocol {
  func login(email:String,password:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func register(phone:String,password:String,email:String,name:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
  func logout(completion:@escaping(Result<BaseResponse<[LogoutModel]>,Error>)->Void)
  func changePassword(currentPassword:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func resetPassword(phone:String,password:String,confirmPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func update(name:String,phone:String,email:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    
    func updateProfileImage(image:MultiPartItem,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func me(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)

}

extension AuthNetworkingProtocol {
  private var auth : AuthRepo {
    return AuthRepo()
  }
  
  func login(email:String,password:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
      auth.request(target: .login(password: password, email: email), completion: completion)
  }
  
  func register(phone:String,password:String,email:String,name:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .register(name: name, phone: phone, password: password, email: email), completion: completion)
  }
  
  func logout(completion:@escaping(Result<BaseResponse<[LogoutModel]>,Error>)->Void) {
    auth.request(target: .logout, completion: completion)
  }
  
  func changePassword(currentPassword:String,newPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
    auth.request(target: .changePassword(currentPassword: currentPassword, newPassword: newPassword), completion: completion)
  }
  
    func resetPassword(phone:String,password:String,confirmPassword:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){
        auth.request(target: .resetPassword(phone: phone, password: password, confirmPassword: confirmPassword), completion: completion)
  }
    
    func update(name:String,phone:String,email:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auth.request(target: .update(name: name, phone: phone, email: email), completion: completion)
    }

    func updateProfileImage(image:MultiPartItem,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auth.request(target: .updateProfileImage(images: image), completion: completion)
    }

    func me(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auth.request(target: .me, completion: completion)
    }

}
