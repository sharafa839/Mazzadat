//////
//////  DataClient.swift
//////  Naseem
//////
//////  Created by Dev Anas on 4/4/19.
//////  Copyright © 2019 Dev Anas. All rights reserved.
//////
////
//import Foundation
//import UIKit
//import CoreData
//import Firebase
//import FirebaseCore
//import FirebaseFirestore
//
//class DataClient: NSObject {
//
//    var delegate : NoIntenetConnection!
//    class var shared  :  DataClient {
//        struct Static{
//            static let instance = DataClient();
//        }
//        return Static.instance
//    }
//
//
//    //Auth functions
//
//
//    class func Register(email : String ,password:String ,name:String,mobile:String,success :   @escaping (_ response : userOB, _ state: String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//        let params = [
//            "email" : email,
//            "password":password,
//            "name":name,
//            "mobile":mobile,
//            "app_locale":"ar",
//            "device_token": AppData.fcmToken,
//            "device_type":"ios"
//            ] as [String : Any]
//
//
//        ApiClient.sendRequest(path: "api/auth/signup", parameters: params, success: { (response) in
//            let dict = response as? NSDictionary ?? [:]
//
//            let status = dict.value(forKey: "status") as? Bool ?? false
//            let msg = dict.value(forKey: "message") as? String ?? ""
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success"{
//
//
//                    if let userData = dict["User"] as? Dictionary<String, AnyObject>{
//                let item = userOB(dictionary:userData)
//                        success(item, "")
//                                      }
//
//                }else{
//
//                    let msg = value["message"] as? [String]
//
//                    success(userOB(dictionary: ["":""]), msg?.first ?? "")
//                }
//
//
//
//
//
//
//                  }else{
//
//
//
//                  }
//
//        }, failure: { (err) in
//            failure(err.errorDescription)
//        }, httpMethod: .post, shouldShowProgress: false, progressMsg: "login..." )
//    }
//    //Auth functions
//
//
//    class func Userlogin(email : String ,password:String, success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//            "email" : email,
//            "password":password,
//            "device_token":AppData.fcmToken,
//            "device_type":"iOS"
//            ] as [String : Any]
//
//
//        ApiClient.sendRequest(path: "api/auth/login", parameters: params, success: { (response) in
//            let dict = response as? NSDictionary ?? [:]
//
//            let status = dict.value(forKey: "status") as? String ?? ""
//            let msg = "Error"
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success" {
//                    if let userData = dict["User"] as? Dictionary<String, AnyObject>{
//                                      let item = userOB(dictionary:userData)
//                                      success(item)
//                                  }
//
//                }else{
//                    if let error = value["message"] as? [String]{
//                        failure(error.first ?? "" )
//
//                    }
//
//                }
//
//
//
//
//
//
//            }
//
//
//
//
//
//
//    }, failure: { (err) in
//    failure(err.errorDescription)
//    }, httpMethod: .post, shouldShowProgress: false, progressMsg: "login..." )
//}
//
//    class func addFave(auctionId:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//            "auction_id":auctionId
//            ] as [String : Any]
//
//
//         ApiClient.sendRequestWithJsonContacts(path: "api/auctions/toggle_favourite?auction_id=\(auctionId)", parameters: params, success: { (response) in
//
//             let dict = response as? NSDictionary ?? [:]
//             let msg = "error"
//
//             if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                 if value["status"] as? String == "success" {
//
//             if let newValue = value["message"] as? [String]{
//                success(newValue.first ?? "")
//                     }
//                 }else{
//                     failure(msg)
//                 }
//
//             }
//
//
//         }, failure: { (err) in
//             failure(err.errorDescription)
//         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//     }
//
//
//    class func restPass(oldPass:String,newPass: String ,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//            "password":newPass,
//            "password_confirmation":newPass,
//            "old_password":oldPass
//
//            ] as [String : Any]
//
//
//        ApiClient.sendRequestJson(path: "api/auth/change_password?old_password=\(oldPass)&password=\(newPass)&password_confirmation=\(newPass)", parameters: [:], success: { (response) in
//
//             let dict = response as? NSDictionary ?? [:]
//             let msg = "error"
//
//             if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                 if value["status"] as? String == "success" {
//
//             if let newValue = value["message"] as? [String]{
//                success(newValue.first ?? "")
//                     }
//                 }else{
//                     failure(msg)
//                 }
//
//             }
//
//
//         }, failure: { (err) in
//             failure(err.errorDescription)
//         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//     }
//
//
//    class func fprgetPass(email:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//            "email":email
//
//            ] as [String : Any]
//
//
//        ApiClient.sendRequest(path:
//            "api/auth/forget_password?email=\(email)", parameters: params, success: { (response) in
//
//             let dict = response as? NSDictionary ?? [:]
//             let msg = "error"
//
//             if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                 if value["status"] as? String == "success" {
//
//             if let newValue = value["message"] as? [String]{
//                success(newValue.first ?? "")
//                     }
//                 }else{
//                     failure(msg)
//                 }
//
//             }
//
//
//         }, failure: { (err) in
//             failure(err.errorDescription)
//         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//     }
//
//    class func restPass(email:String,newPass: String, confrimPass: String, code: Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//            "email":email,
//            "password":email,
//            "password_confirmation":email,
//            "code":email
//
//            ] as [String : Any]
//
//        ApiClient.sendRequestJson(path:
//                                    "api/auth/reset_password?email=\(email)&password=\(newPass)&password_confirmation=\(confrimPass)&code=\(code)", parameters: [:], success: { (response) in
//
//             let dict = response as? NSDictionary ?? [:]
//             let msg = "error"
//
//             if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                 if value["status"] as? String == "success" {
//
//             if let newValue = value["message"] as? [String]{
//                success(newValue.first ?? "")
//                     }
//                 }else{
//                    if let newValue = value["message"] as? [String]{
//                                    failure(newValue.first ?? "")
//                                         }
//
//                 }
//
//             }
//
//
//         }, failure: { (err) in
//             failure(err.errorDescription)
//         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: false)
//     }
//
//    class func recoverMoney(success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//
//        ApiClient.sendRequestWithJsonContacts(path: "api/transactions/request_refund", parameters: [:], success: { (response) in
//
//                let dict = response as? NSDictionary ?? [:]
//                let msg = "error"
//
//                if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                    if value["status"] as? String == "success" {
//
//                if let newValue = value["message"] as? [String]{
//                   success(newValue.first ?? "")
//                        }
//                    }else{
//                        failure(msg)
//                    }
//
//                }
//
//
//            }, failure: { (err) in
//                failure(err.errorDescription)
//            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//        }
//
//
//    class func addCodeVerfiy(code:Int,type: Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//           let params = [
//               "code":code,
//               "type":1
//               ] as [String : Any]
//
//
//        ApiClient.sendRequest(path: "api/auth/verify?code=\(code)&type=\(1)", parameters: [:], success: { (response) in
//
//                let dict = response as? NSDictionary ?? [:]
//                let error = "error"
//
//                if let value = dict["status"] as? Dictionary<String, AnyObject>{
//                    if value["status"] as? String == "success" {
//
//                if let newValue = value["message"] as? [String]{
//                   success(newValue.first ?? "")
//                        }
//                    }else{
//
//                        if let newValue = value["message"] as? [String]{
//                                        failure(newValue.first ?? "")
//                                             }
//
//                    }
//
//                }
//
//
//            }, failure: { (err) in
//                failure(err.errorDescription)
//            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//        }
//
//
//
//    class func getCat(success :   @escaping (_ response : [CategoryOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequest(path: "api/install", parameters: [:], success: { (response) in
//
//            let dict = response as? NSDictionary ?? [:]
//            let msg = "error"
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success" {
//
//            if let newValue = dict["data"] as? Dictionary<String, AnyObject>{
//
//                 var data: [CategoryOB] = []
//
//                     if let value = newValue["Categories"] as? Array<Dictionary<String, AnyObject>> {
//
//                    for itemDic in value {
//                    let item = CategoryOB(dictionary:itemDic)
//                     data.append(item)
//                        }
//                        success(data)
//                        }
//                    }
//
//                }else{
//                    failure(msg)
//
//                }
//
//            }
//
//
//        }, failure: { (err) in
//            failure(err.errorDescription)
//        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: false)
//    }
//
//
//
//    class func getDataQ(success :   @escaping (_ response : [QestionOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequest(path: "api/home/faqs?q=", parameters: [:], success: { (response) in
//
//            let dict = response as? NSDictionary ?? [:]
//            let msg = "error"
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success" {
//
//
//                 var data: [QestionOB] = []
//
//                     if let value = dict["FaqsCategories"] as? Array<Dictionary<String, AnyObject>> {
//
//                    for itemDic in value {
//                    let item = QestionOB(dictionary:itemDic)
//                     data.append(item)
//                        }
//                        success(data)
//                        }
//
//
//                }else{
//                    failure(msg)
//
//                }
//
//            }
//
//
//        }, failure: { (err) in
//            failure(err.errorDescription)
//        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//    }
//
//
//    class func getPolicy(success :   @escaping (_ response : settingOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequest(path: "api/install", parameters: [:], success: { (response) in
//
//            let dict = response as? NSDictionary ?? [:]
//            let msg = "error"
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success" {
//
//            if let newValue = dict["data"] as? Dictionary<String, AnyObject>{
//
//
//                     if let value = newValue["Settings"] as? Dictionary<String, AnyObject> {
//
//                        let item = settingOB(dictionary:value)
//
//                        success(item)
//                        }
//                    }
//
//                }else{
//                    failure(msg)
//
//                }
//
//            }
//
//
//        }, failure: { (err) in
//            failure(err.errorDescription)
//        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: false)
//    }
//
//
//    class func getDocTypes(success :   @escaping (_ response : [DocOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//           ApiClient.sendRequest(path: "api/install", parameters: [:], success: { (response) in
//
//               let dict = response as? NSDictionary ?? [:]
//               let msg = "error"
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                   if value["status"] as? String == "success" {
//
//               if let newValue = dict["data"] as? Dictionary<String, AnyObject>{
//
//                    var data: [DocOB] = []
//
//                        if let value = newValue["DocumentsTypes"] as? Array<Dictionary<String, AnyObject>> {
//
//                       for itemDic in value {
//                       let item = DocOB(dictionary:itemDic)
//                        data.append(item)
//                           }
//                           success(data)
//                           }
//                       }
//
//                   }else{
//                       failure(msg)
//
//                   }
//
//               }
//
//
//           }, failure: { (err) in
//               failure(err.errorDescription)
//           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: false)
//       }
//
//
//
//    class func verifyEmail(type: Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//
//            let params = [
//                "type":1
//                ] as [String : Any]
//
//
//           ApiClient.sendRequest(path: "api/auth/resend_verify", parameters: params, success: { (response) in
//
//               let dict = response as? NSDictionary ?? [:]
//               let msg = "error"
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                   if value["status"] as? String == "success" {
//
//        success("")
//
//                   }else{
//                       failure(msg)
//
//                   }
//
//               }
//
//
//           }, failure: { (err) in
//               failure(err.errorDescription)
//           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//       }
//
//
//    class func editProfile(name:String, email: String, mobile: String,success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//        let params = [
//                      "name":name,
//                      "mobile":mobile,
//                      "email":email
//
//                   ] as [String : Any]
//
//
//          ApiClient.sendRequest(path: "api/auth/update", parameters: params, success: { (response) in
//
//              let dict = response as? NSDictionary ?? [:]
//              let msg = "error"
//
//         if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                             if value["status"] as? String == "success"{
//
//
//                                 if let userData = dict["User"] as? Dictionary<String, AnyObject>{
//
//
//                                    let token = userData["access_token"] as? String
//                                    AppData.userToken = token ?? ""
//
//
//                             let item = userOB(dictionary:userData)
//
//
//
//                                     success(item)
//                                                   }
//
//
//
//                             }else{
//
//                                 let msg = value["message"] as? [String]
//
//                             }
//
//
//
//
//
//
//                               }else{
//
//
//
//                               }
//
//
//
//          }, failure: { (err) in
//              failure(err.errorDescription)
//          }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//      }
//
//    class func getDocuments(success :   @escaping (_ response : [DocOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//           ApiClient.sendRequest(path: "api/home/documents", parameters: [:], success: { (response) in
//
//               let dict = response as? NSDictionary ?? [:]
//               let msg = "error"
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                   if value["status"] as? String == "success" {
//
//
//
//                    var data: [DocOB] = []
//
//                        if let value = dict["Documents"] as? Array<Dictionary<String, AnyObject>> {
//
//                       for itemDic in value {
//                       let item = DocOB(dictionary:itemDic)
//                        data.append(item)
//                           }
//                           success(data)
//                           }
//
//
//                   }else{
//                       failure(msg)
//
//                   }
//
//               }
//
//
//           }, failure: { (err) in
//               failure(err.errorDescription)
//           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//       }
//
//    class func getBanks(success :   @escaping (_ response : [banksOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//          ApiClient.sendRequest(path: "api/install", parameters: [:], success: { (response) in
//
//              let dict = response as? NSDictionary ?? [:]
//              let msg = "error"
//
//              if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                  if value["status"] as? String == "success" {
//
//              if let newValue = dict["data"] as? Dictionary<String, AnyObject>{
//
//                var data: [banksOB] = []
//
//                       if let value = newValue["BankAccounts"] as?  Array<Dictionary<String, AnyObject>> {
//
//                        for itemDic in value {
//                        let item = banksOB(dictionary:itemDic)
//                         data.append(item)
//                            }
//                          success(data)
//                          }
//                      }
//
//                  }else{
//                      failure(msg)
//
//                  }
//
//              }
//
//
//          }, failure: { (err) in
//              failure(err.errorDescription)
//          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//      }
//    class func getPakges(success :   @escaping (_ response : [SubscribeOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//          ApiClient.sendRequest(path: "api/install", parameters: [:], success: { (response) in
//
//              let dict = response as? NSDictionary ?? [:]
//              let msg = "error"
//
//              if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                  if value["status"] as? String == "success" {
//
//              if let newValue = dict["data"] as? Dictionary<String, AnyObject>{
//
//                   var data: [SubscribeOB] = []
//
//                       if let value = newValue["Subscriptions"] as? Array<Dictionary<String, AnyObject>> {
//
//                      for itemDic in value {
//                      let item = SubscribeOB(dictionary:itemDic)
//                       data.append(item)
//                          }
//                          success(data)
//                          }
//                      }
//
//                  }else{
//                      failure(msg)
//
//                  }
//
//              }
//
//
//          }, failure: { (err) in
//              failure(err.errorDescription)
//          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: false)
//      }
//
//    class func getTickets(success :   @escaping (_ response : [TikectOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//             ApiClient.sendRequest(path: "api/tickets", parameters: [:], success: { (response) in
//
//                 let dict = response as? NSDictionary ?? [:]
//                 let msg = "error"
//
//                 if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                     if value["status"] as? String == "success" {
//
//                      var data: [TikectOB] = []
//
//                          if let value = dict["Tickets"] as? Array<Dictionary<String, AnyObject>> {
//
//                         for itemDic in value {
//                         let item = TikectOB(dictionary:itemDic)
//                          data.append(item)
//                             }
//                             success(data)
//                             }
//
//
//                     }else{
//                         failure(msg)
//
//                     }
//
//                 }
//
//
//             }, failure: { (err) in
//                 failure(err.errorDescription)
//             }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//         }
//
//
//
//    class func showTickets(id:Int,success :   @escaping (_ response : TikectOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//                ApiClient.sendRequest(path: "api/tickets/show?ticket_id=\(id)", parameters: [:], success: { (response) in
//
//                    let dict = response as? NSDictionary ?? [:]
//                    let msg = "error"
//
//                    if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                        if value["status"] as? String == "success" {
//
//
//                             if let value = dict["Ticket"] as? Dictionary<String, AnyObject> {
//
//
//                let item = TikectOB(dictionary:value)
//                                success(item)
//                                }
//
//
//                        }else{
//                            failure(msg)
//
//                        }
//
//                    }
//
//
//                }, failure: { (err) in
//                    failure(err.errorDescription)
//                }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//            }
//
//
//
//    class func addComment(id:Int,comment:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequest(path: "api/tickets/response?ticket_id=\(id)&&response=\(comment)".addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!, parameters: [:], success: { (response) in
//
//                      let dict = response as? NSDictionary ?? [:]
//                      let msg = "error"
//
//                      if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                          if value["status"] as? String == "success" {
//                                               success("")
//
//
//
//                          }else{
//                              failure(msg)
//
//                          }
//
//                      }
//
//
//                  }, failure: { (err) in
//                      failure(err.errorDescription)
//                  }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//              }
//
//
//    class func getMyAucationsFilter(catId: Int,filterType: String, code: String, startDate: String, EndDate: String, priceFrom: Int,priceTo: Int ,success :   @escaping (_ response : [AuctionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//           var params = ["category_id":catId] as [String : Any]
//
//           switch filterType {
//           case "none":
//               params =  ["category_id":catId]
//
//          case "code":
//               params = ["code":code,"category_id":catId]
//
//           case "endDate":
//               params = ["end_at_to":EndDate,"category_id":catId]
//
//           case "startDate":
//               params = ["end_at_from":startDate,"category_id":catId]
//
//            case "endDate&StartDate":
//               params = ["end_at_to":EndDate,
//                         "end_at_from":startDate,"category_id":catId ]
//
//
//           case "priceTo":
//           params = ["price_to":priceTo,"category_id":catId]
//
//
//       case "priceFrom":
//               params = ["price_from":priceFrom,"category_id":catId]
//
//       case "priceFrom&To":
//                params = ["price_to":priceTo,
//                         "price_from":priceFrom, "category_id":catId]
//           default:
//               break
//           }
//
//
//
//             ApiClient.sendRequest(path: "api/auctions", parameters: params, success: { (response) in
//
//                 let dict = response as? NSDictionary ?? [:]
//                 let msg = "error"
//
//                 if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                     if value["status"] as? String == "success" {
//
//
//                      var data: [AuctionsOB] = []
//
//                          if let value = dict["Auctions"] as? Array<Dictionary<String, AnyObject>> {
//
//                         for itemDic in value {
//                         let item = AuctionsOB(dictionary:itemDic)
//                          data.append(item)
//                             }
//                             success(data)
//                             }
//
//
//                     }else{
//                         failure(msg)
//
//                     }
//
//                 }
//
//
//             }, failure: { (err) in
//                 failure(err.errorDescription)
//             }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//         }
//
//
//    class func getAdvertiseAucations(success :   @escaping (_ response : [AuctionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//
//         let params = [
//                             "per_page":50,
//                             "is_advertisement":true
//
//                          ] as [String : Any]
//
//
//           ApiClient.sendRequest(path: "api/auctions", parameters: params, success: { (response) in
//
//               let dict = response as? NSDictionary ?? [:]
//               let msg = "error"
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                   if value["status"] as? String == "success" {
//
//
//                    var data: [AuctionsOB] = []
//
//                        if let value = dict["Auctions"] as? Array<Dictionary<String, AnyObject>> {
//
//                       for itemDic in value {
//                       let item = AuctionsOB(dictionary:itemDic)
//                        data.append(item)
//                           }
//                           success(data)
//                           }
//
//
//                   }else{
//                       failure(msg)
//
//                   }
//
//               }
//
//
//           }, failure: { (err) in
//               failure(err.errorDescription)
//           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//       }
//
//
//    class func getMyCartAucation(page:Int,success :   @escaping (_ response : [AuctionsOB], _ total : Int )  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//
//            let params = [
//                                "my_purchases":true,
//                "page":page
//
//
//                             ] as [String : Any]
//
//
//              ApiClient.sendRequest(path: "api/auctions", parameters: params, success: { (response) in
//
//                  let dict = response as? NSDictionary ?? [:]
//                  let msg = "error"
//                var totelPg = 1
//
//
//                if let valueData = dict["paging"] as? Dictionary<String, AnyObject>{
//
//                    totelPg = valueData["last_page"] as? Int ?? 0
//                }
//                  if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                      if value["status"] as? String == "success" {
//
//
//                       var data: [AuctionsOB] = []
//
//                           if let value = dict["Auctions"] as? Array<Dictionary<String, AnyObject>> {
//
//                          for itemDic in value {
//                          let item = AuctionsOB(dictionary:itemDic)
//                           data.append(item)
//                              }
//                            success(data, totelPg)
//                              }
//
//
//                      }else{
//                          failure(msg)
//
//                      }
//
//                  }
//
//
//              }, failure: { (err) in
//                  failure(err.errorDescription)
//              }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//          }
//
//    class func getAllNoti(success :   @escaping (_ response : [NotiOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//
//        ApiClient.sendRequest(path: "api/notifications", parameters: [:], success: { (response) in
//
//                     let dict = response as? NSDictionary ?? [:]
//                     let msg = "error"
//
//                     if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                         if value["status"] as? String == "success" {
//
//
//                          var data: [NotiOB] = []
//
//                              if let value = dict["Notifications"] as? Array<Dictionary<String, AnyObject>> {
//
//                             for itemDic in value {
//                             let item = NotiOB(dictionary:itemDic)
//                              data.append(item)
//                                 }
//                                 success(data)
//                                 }
//
//
//                         }else{
//                             failure(msg)
//
//                         }
//
//                     }
//
//
//                 }, failure: { (err) in
//                     failure(err.errorDescription)
//                 }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//             }
//
//
//    class func getMySunscribe(success :   @escaping (_ response : [MySubscribeOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequest(path: "api/transactions", parameters: [:], success: { (response) in
//
//                     let dict = response as? NSDictionary ?? [:]
//                     let msg = "error"
//
//                     if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                         if value["status"] as? String == "success" {
//
//
//                          var data: [MySubscribeOB] = []
//
//                              if let value = dict["Transactions"] as? Array<Dictionary<String, AnyObject>> {
//
//                             for itemDic in value {
//                             let item = MySubscribeOB(dictionary:itemDic)
//                              data.append(item)
//                                 }
//                                 success(data)
//                                 }
//
//
//                         }else{
//                             failure(msg)
//
//                         }
//
//                     }
//
//
//                 }, failure: { (err) in
//                     failure(err.errorDescription)
//                 }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//             }
//
//
//    class func readNoti(notiId:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//                           "notification_id":notiId
//
//                        ] as [String : Any]
//
//
//        ApiClient.sendRequest(path: "api/notifications/read?notification_id=\(notiId)", parameters: [:], success: { (response) in
//
//                     let dict = response as? NSDictionary ?? [:]
//                     let msg = "error"
//
//            if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                if value["status"] as? String == "success" {
//
//                   if let msg =  value["message"] as? [String] {
//                       success(msg.first ?? "")
//                   }
//
//
//
//                }else{
//
//                 if let msg = value["message"] as? [String]{
//                     failure(msg.first ?? "")
//                 }
//
//
//                }
//
//            }
//
//
//                 }, failure: { (err) in
//                     failure(err.errorDescription)
//                 }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//             }
//
//    class func getMyAucations(success :   @escaping (_ response : [AuctionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//                           "my_bids":true
//
//                        ] as [String : Any]
//
//
//
//          ApiClient.sendRequest(path: "api/auctions", parameters: params, success: { (response) in
//
//              let dict = response as? NSDictionary ?? [:]
//              let msg = "error"
//
//              if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                  if value["status"] as? String == "success" {
//
//
//                   var data: [AuctionsOB] = []
//
//                       if let value = dict["Auctions"] as? Array<Dictionary<String, AnyObject>> {
//
//                      for itemDic in value {
//                      let item = AuctionsOB(dictionary:itemDic)
//                       data.append(item)
//                          }
//                          success(data)
//                          }
//
//
//                  }else{
//                      failure(msg)
//
//                  }
//
//              }
//
//
//          }, failure: { (err) in
//              failure(err.errorDescription)
//          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//      }
//
//
//    class func getMyFave(success :   @escaping (_ response : [AuctionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//        ApiClient.sendRequest(path: "api/auctions/favourites", parameters: [:], success: { (response) in
//
//                 let dict = response as? NSDictionary ?? [:]
//                 let msg = "error"
//
//                 if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                     if value["status"] as? String == "success" {
//
//
//                      var data: [AuctionsOB] = []
//
//                          if let value = dict["Auctions"] as? Array<Dictionary<String, AnyObject>> {
//
//                         for itemDic in value {
//                         let item = AuctionsOB(dictionary:itemDic)
//                          data.append(item)
//                             }
//                             success(data)
//                             }
//
//
//                     }else{
//                         failure(msg)
//
//                     }
//
//                 }
//
//
//             }, failure: { (err) in
//                 failure(err.errorDescription)
//             }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//         }
//
//    class func addBid(auctionId:Int,price:Double,success :   @escaping (_ response : AuctionsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//          let params = [
//                      "price":price
//
//                   ] as [String : Any]
//
//
//               ApiClient.sendRequestWithJsonContacts(path: "api/auctions/add_bid?auction_id=\(auctionId)&price=\(price)", parameters:params, success: { (response) in
//
//                   let dict = response as? NSDictionary ?? [:]
//                   let msg = "error"
//
//                     if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                               if value["status"] as? String == "success" {
//
//
//                                    if let value = dict["Auction"] as? Dictionary<String, AnyObject> {
//
//                                      let item = AuctionsOB(dictionary:value)
//
//                                       success(item)
//                                       }
//
//
//                               }else{
//
//
//                                if let msg =  value["message"] as? [String] {
//                                    failure(msg.first ?? "")
//
//                                }
//
//
//                               }
//
//                           }
//
//
//
//               }, failure: { (err) in
//                   failure(err.errorDescription)
//               }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//           }
//
//
//    class func addBidInFireStore(bidId:Int,auctionId:Int,price:Double,success :   @escaping (_ response : Bool)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let db = Firestore.firestore()
//        var ref: DocumentReference? = nil
//        ref = db.collection("aution::").document("\(auctionId)::\(auctionId)").collection("\(auctionId)::\(auctionId)").addDocument(data: [
//            "creationDate": Timestamp(),
//            "id": "\(bidId)",
//            "price": "\(price)",
//            "userName":AppData.username,
//            "user_id":"\(AppData.userId)"
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                success(true)
//
//            }
//        }
//
//
//
//              }
//
//    class func addTikcet(title:String,message:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        ApiClient.sendRequestWithJsonContacts(path: "api/tickets/store?title=\(title)&&message=\(message)".addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) ?? "", parameters:[:], success: { (response) in
//
//                     let dict = response as? NSDictionary ?? [:]
//                     let msg = "error"
//
//                     if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                         if value["status"] as? String == "success" {
//
//                            if let msg =  value["message"] as? [String] {
//                                success(msg.first ?? "")
//                            }
//
//
//
//                         }else{
//
//                          if let msg = value["message"] as? [String]{
//                              failure(msg.first ?? "")
//                          }
//
//
//                         }
//
//                     }
//
//
//                 }, failure: { (err) in
//                     failure(err.errorDescription)
//                 }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//             }
//
//
//    class func uploadImg(frontImg : UIImage ,backImg: UIImage,id:Int,expiry_date:String, success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//            let frontimageName = "img-\(CACurrentMediaTime()).png"
//            let backImgName = "img-\(CACurrentMediaTime()).png"
//
//            let paramss = [
//                "document_type_id" : "\(id)",
//                "expiry_date":expiry_date
//
//                ] as [String : Any]
//
//            ApiClient.uploadDocumentImages(path: "https://app.golden-auctions.com/api/home/upload_document", success: { (response) in
//                let dict = response as? NSDictionary ?? [:]
//                let status = dict.value(forKey: "status") as? String ?? ""
//                let msg = dict.value(forKey: "filename") as? String ?? ""
//
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                                    if value["status"] as? String == "success" {
//
//
//                                     success("sucess")
//
//
//
//                                    }else{
//
//                                     if let msg = value["message"] as? [String]{
//                                         failure(msg.first ?? "")
//                                     }
//
//
//                                    }
//
//                                }
//
//            }, failure: { (err) in
//                failure(err.errorDescription)
//
//            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?",backImg:backImg, forntImg:frontImg , imageKeyName: "img", fileName: frontimageName, params: paramss, isRequireHeader: true)
//        }
//
//    class func transferWirePay(img : UIImage ,subscription_id:Int, success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//            let imageName = "img-\(CACurrentMediaTime()).png"
//
//            let paramss = [
//                "subscription_id" : "\(subscription_id)",
//                "payment_method":"\(1)"
//
//                ] as [String : Any]
//
//            ApiClient.sendRequestWithImage(path: "https://app.golden-auctions.com/api/home/subscribe", success: { (response) in
//                let dict = response as? NSDictionary ?? [:]
//                let status = dict.value(forKey: "status") as? String ?? ""
//                let msg = dict.value(forKey: "filename") as? String ?? ""
//
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                                    if value["status"] as? String == "success" {
//
//
//                                        if let sucessMsg = value["message"] as? [String]  {
//                                            success(sucessMsg.first ?? "")
//                                        }
//
//
//
//                                    }else{
//
//                                     if let msg = value["message"] as? [String]{
//                                         failure(msg.first ?? "")
//                                     }
//
//
//                                    }
//
//                                }
//
//            }, failure: { (err) in
//                failure(err.errorDescription)
//
//           }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: img,imageKeyName: "payment_detail", fileName: imageName, params: paramss, isRequireHeader: true)
//        }
//
//
//    class func uploadProfileImg(img : UIImage , success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//            let imageName = "img-\(CACurrentMediaTime()).png"
//
//
//            ApiClient.sendRequestWithImage(path: "https://app.golden-auctions.com/api/auth/update", success: { (response) in
//                let dict = response as? NSDictionary ?? [:]
//                let status = dict.value(forKey: "status") as? String ?? ""
//
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                                    if value["status"] as? String == "success" {
//
//
//                                        if let sucessMsg = value["message"] as? [String]  {
//
//
//                                        if let userData = dict["User"] as? Dictionary<String, AnyObject>{
//
//                                            let token = userData["access_token"] as? String
//                                            AppData.userToken = token ?? ""
//
//
//                                            success(sucessMsg.first ?? "")
//
//
//                                            }
//                                        }
//
//
//
//                                    }else{
//
//                                     if let msg = value["message"] as? [String]{
//                                         failure(msg.first ?? "")
//                                     }
//
//
//                                    }
//
//                                }
//
//            }, failure: { (err) in
//                failure(err.errorDescription)
//
//            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: img,imageKeyName: "avatar", fileName: imageName, params: [:], isRequireHeader: true)
//        }
//
//
//    class func payCash(subscription_id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//             let params = [
//                "subscription_id":subscription_id,
//                "payment_method":2
//
//                      ] as [String : Any]
//
//
//                  ApiClient.sendRequestWithJsonContacts(path: "api/home/subscribe?subscription_id=2&payment_method=2", parameters:params, success: { (response) in
//
//                      let dict = response as? NSDictionary ?? [:]
//                      let msg = "error"
//
//                      if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                          if value["status"] as? String == "success" {
//
//                            if let sucessMsg = value["message"] as? [String]  {
//                                success(sucessMsg.first ?? "")
//                            }
//
//
//
//                          }else{
//
//                           if let msg = value["message"] as? [String]{
//                               failure(msg.first ?? "")
//                           }
//
//
//                          }
//
//                      }
//
//
//                  }, failure: { (err) in
//                      failure(err.errorDescription)
//                  }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//              }
//
//
//
//
//    class func getSingleAucations(auctionId:Int,success :   @escaping (_ response : AuctionsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//        let params = [
//                 "auction_id":auctionId
//                 ] as [String : Any]
//
//
//             ApiClient.sendRequest(path: "api/auctions/show", parameters:params, success: { (response) in
//
//                 let dict = response as? NSDictionary ?? [:]
//                 let msg = "error"
//
//                 if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                     if value["status"] as? String == "success" {
//
//
//                          if let value = dict["Auction"] as? Dictionary<String, AnyObject> {
//
//                            let item = AuctionsOB(dictionary:value)
//
//                             success(item)
//                             }
//
//
//                     }else{
//                         failure(msg)
//
//                     }
//
//                 }
//
//
//             }, failure: { (err) in
//                 failure(err.errorDescription)
//             }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//         }
//
//
//
//      class func getRealTimeAucation(auctionId:Int,success :   @escaping (_ response : [AuctionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//
//              let db = Firestore.firestore()
//
//          db.collection("aution::").document("\(auctionId)::\(auctionId)")
//              .collection("\(auctionId)::\(auctionId)").addSnapshotListener { querySnapshot2, error in
//
////                   if let value = querySnapshot2?.documents.first?.data() as? Dictionary<String, AnyObject> {
////
////                   let item = AuctionsOB(dictionary:value)
////
////                    success(item)
////
////
////
////
////        }
//
//
//            var data: [AuctionsOB] = []
//
//                 for document2 in querySnapshot2!.documents {
//                    let item = AuctionsOB(dictionary:document2.data())
//                                            data.append(item)
//                }
//                success(data)
//
////
////             if let value = querySnapshot2?.documents as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    itemDic.
////                        let item = AuctionsOB(dictionary:itemDic.)
////                                 data.append(item)
////                                    }
////                                    success(data)
////                                    }
//
//           }
//    }
//
//
//
//    class func getMyProfile(success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
//
//           ApiClient.sendRequest(path: "api/auth/me", parameters: [:], success: { (response) in
//
//               let dict = response as? NSDictionary ?? [:]
//               let msg = "error"
//
//               if let value = dict["status"] as? Dictionary<String, AnyObject>{
//
//                   if value["status"] as? String == "success" {
//
//
//                        if let value = dict["User"] as? Dictionary<String, AnyObject> {
//                            let item = userOB(dictionary:value)
//                           success(item)
//                           }
//
//                   }else{
//                       failure(msg)
//
//                   }
//
//               }
//
//
//           }, failure: { (err) in
//               failure(err.errorDescription)
//           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
//       }
////
////
//
////    class func verifyAcount(code : Int ,type:Int, success :   @escaping (_ response : matchesOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////             let params = [
////                 "code" : code,
////                 "type":type
////                ] as [String : Any]
////
////
////             ApiClient.sendRequestWithJsonContacts(path: "api/expectations/expect", parameters: params, success: { (response) in
////                 let dict = response as? NSDictionary ?? [:]
////
////                 let status = dict.value(forKey: "status") as? String ?? ""
////                 let msg = "Error"
////
////                 if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                     if value["status"] as? String == "success" {
////                         if let userData = dict["Match"] as? Dictionary<String, AnyObject>{
////                                           let item = matchesOB(dictionary:userData)
////                                           success(item)
////                                       }
////
////                     }else{
////
////                         failure(msg)
////
////                     }
////
////
////
////
////
////
////                 }
////
////
////
////
////
////
////         }, failure: { (err) in
////         failure(err.errorDescription)
////         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////     }
////    class func UpdatePassord(email : String ,password:String,password_confirmation:String, success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////            let params = [
////                "email" : email,
////                "password":password,
////                "device_token":"device_token123",
////                "device_type":"iOS"
////                ] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "api/auth/login", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////
////                let status = dict.value(forKey: "status") as? String ?? ""
////                let msg = "Error"
////
////                if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                    if value["status"] as? String == "success" {
////                        if let userData = dict["User"] as? Dictionary<String, AnyObject>{
////                                          let item = userOB(dictionary:userData)
////                                          success(item)
////                                      }
////
////                    }else{
////
////                        failure(msg)
////
////                    }
////
////
////
////
////
////
////                }
////
////
////
////
////
////
////        }, failure: { (err) in
////        failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: false, progressMsg: "login..." )
////    }
////    //
////
////
////    class func subscriptionsWithLega(id:Int,success :   @escaping (_ response : Bool)  -> Void , failure :  @escaping (_ err : String) -> Void){
////            let params = [
////                "league_id" : "\(id)"
////                ] as [String : Any]
////
////
////        ApiClient.sendRequestWithJsonContacts(path: "api/subscriptions/toggle", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////
////                    success(true)
////
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func forgetPassword(email:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////            let params = [
////                "email" :email
////                ] as [String : Any]
////
////
////        ApiClient.sendRequestWithJsonContacts(path: "/api/auth/forget_password", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////               if let msg =  value["message"] as? [String]  {
////                success(msg.first ?? "")
////                    }
////
////                }else{
////
////                    if let msg =  value["message"] as? [String]  {
////                                 failure(msg.first ?? "")
////                                     }
////
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func restPass(email:String,password:String,code:String,passwordConfirm:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////               let params = [
////                   "email" :email,
////                   "code" :code,
////                "password" :password,
////                "password_confirmation" :passwordConfirm
////
////                   ] as [String : Any]
////
////
////           ApiClient.sendRequestWithJsonContacts(path: "api/auth/reset_password", parameters: params, success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = "error"
////
////               if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                   if value["status"] as? String == "success" {
////                  if let msg =  value["message"] as? [String]  {
////                   success(msg.first ?? "")
////                       }
////
////                   }else{
////
////                       if let msg =  value["message"] as? [String]  {
////                                    failure(msg.first ?? "")
////                                        }
////
////
////                   }
////
////               }
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////       }
////    class func UpdateProfile(email:String,name:String,mobile:String,mobile_code:String,success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let params = [
////              "email" : email,
////              "name":name,
////              "mobile":mobile,
////              "mobile_code":mobile_code
////              ] as [String : Any]
////
////        ApiClient.sendRequest(path: "api/auth/update", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    if let value = dict["User"] as? Dictionary<String, AnyObject> {
////
////                        let item = userOB(dictionary:value)
////                               success(item)
////                           }
////                }else{
////                    failure(msg)
////                }
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func GetProfile(success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/auth/me", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    if let value = dict["User"] as? Dictionary<String, AnyObject> {
////
////                        let item = userOB(dictionary:value)
////                               success(item)
////                           }
////                }else{
////                    failure(msg)
////                }
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////
////    class func AAddLega(name:String,description:String,prize:String,parent_id:Int ,success:   @escaping (_ response : legaOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let paramss = [           "name" : description,
////
////                            "description" : description,
////                            "prize" : prize,
////                            "parent_id" : parent_id] as [String : Any]
////
////        ApiClient.sendRequestWithJsonContacts(path: "api/leagues", parameters: paramss, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    if let value = dict["League"] as? Dictionary<String, AnyObject> {
////
////                        let item = legaOB(dictionary:value)
////                               success(item)
////                           }
////                }else{
////                    failure(msg)
////                }
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////
////    class func updDateMyLega(name:String,description:String,prize:String,parent_id:Int ,success:   @escaping (_ response : legaOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////           let paramss = [           "name" : description,
////
////                               "description" : description,
////                               "prize" : prize,
////                               "parent_id" : parent_id] as [String : Any]
////
////           ApiClient.sendRequestWithJsonContacts(path: "api/leagues/update", parameters: paramss, success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = "error"
////
////               if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                   if value["status"] as? String == "success" {
////
////                       if let value = dict["League"] as? Dictionary<String, AnyObject> {
////
////                           let item = legaOB(dictionary:value)
////                                  success(item)
////                              }
////                   }else{
////                       failure(msg)
////                   }
////               }
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////       }
////
////
//////
////        class func AddLega(description:String,prize:String,parent_id:String,logo:UIImage, success :   @escaping (_ response : legaOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////                  let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////
////                  let paramss = [
////                      "description" : description,
////                      "prize" : prize,
////                      "parent_id" : parent_id,
////                      "logo": ""] as [String : Any]
////
////
////                  ApiClient.sendRequestWithImage(path: "api/leagues", success: { (response) in
////                      let dict = response as? NSDictionary ?? [:]
////
////                           let status = dict.value(forKey: "status") as? Bool ?? false
////                           let msg = "error"
////
////                           if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                               if value["status"] as? String == "success" {
////
////
////                                   if let value = dict["League"] as? Dictionary<String, AnyObject> {
////                                    let item = legaOB(dictionary:value)
////                                              success(item)
////
////                                          }
////                            }
////
////                     }else{
////                         failure(msg)
////
////                     }             }, failure: { (err) in
////                      failure(err.errorDescription)
////
////                  }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: logo,imageKeyName: "logo", fileName: imageName, params: paramss, isRequireHeader: true)
////              }
//
//
//
////class func legaLists(success :   @escaping (_ response : [legaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "api/leagues", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = "error"
////
////        if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////            if value["status"] as? String == "success" {
////
////                var data: [legaOB] = []
////                if let value = dict["Leagues"] as? Array<Dictionary<String, AnyObject>> {
////
////                           for itemDic in value {
////                               let item = legaOB(dictionary:itemDic)
////                               data.append(item)
////                           }
////
////                           success(data)
////
////                       }
////
////            }else{
////                failure(msg)
////
////            }
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////}
////
////
////    class func myLegaSub(success :   @escaping (_ response : [legaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/subscriptions", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    var data: [legaOB] = []
////                    if let value = dict["Leagues"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = legaOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////
////    class func GetMylegaLists(success :   @escaping (_ response : [legaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/leagues/my", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    var data: [legaOB] = []
////                    if let value = dict["Leagues"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = legaOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func GetGenarlPoint(success :   @escaping (_ response : [topExpectOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////           ApiClient.sendRequest(path: "api/expectations/top", parameters: [:], success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = "error"
////
////               if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                   if value["status"] as? String == "success" {
////
////                       var data: [topExpectOB] = []
////                       if let value = dict["TopExpectation"] as? Array<Dictionary<String, AnyObject>> {
////
////                                  for itemDic in value {
////                                      let item = topExpectOB(dictionary:itemDic)
////                                      data.append(item)
////                                  }
////
////                                  success(data)
////
////                              }
////
////                   }else{
////                       failure(msg)
////
////                   }
////
////               }
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////       }
////
////
////
////    class func GetCoustmlegaLists(leagId:Int,success :   @escaping (_ response : [legaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/leagues/custom?parent_id=\(leagId)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    var data: [legaOB] = []
////                    if let value = dict["Leagues"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = legaOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////
////    class func getExpection(states:Int,success :   @escaping (_ response : [matchesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/expectations?status=\(states)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    var data: [matchesOB] = []
////                    if let value = dict["Matches"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = matchesOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////
////    class func getFaveLageas(states:Int,success :   @escaping (_ response : [legaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/favourites?type=\(states)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////                    var data: [legaOB] = []
////                    if let value = dict["Leagues"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = legaOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func getFaveMatch(states:Int,success :   @escaping (_ response : [matchesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////          ApiClient.sendRequest(path: "api/favourites?type=\(states)", parameters: [:], success: { (response) in
////              let dict = response as? NSDictionary ?? [:]
////
////              let status = dict.value(forKey: "status") as? Bool ?? false
////              let msg = "error"
////
////              if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                  if value["status"] as? String == "success" {
////
////                      var data: [matchesOB] = []
////                      if let value = dict["Matches"] as? Array<Dictionary<String, AnyObject>> {
////
////                                 for itemDic in value {
////                                     let item = matchesOB(dictionary:itemDic)
////                                     data.append(item)
////                                 }
////
////                                 success(data)
////
////                             }
////
////                  }else{
////                      failure(msg)
////
////                  }
////
////              }
////
////
////          }, failure: { (err) in
////              failure(err.errorDescription)
////          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////      }
////
////
////    class func getMatches(states:Int,success :   @escaping (_ response : [matchesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "api/matches?status=\(states)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            var err = ""
////            let status = dict.value(forKey: "status") as? Bool ?? false
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                let msg = value["mesaage"] as? [String] ?? []
////
////                err = msg.first ?? ""
////                if value["status"] as? String == "success" {
////
////                    var data: [matchesOB] = []
////                    if let value = dict["Matches"] as? Array<Dictionary<String, AnyObject>> {
////
////                               for itemDic in value {
////                                   let item = matchesOB(dictionary:itemDic)
////                                   data.append(item)
////                               }
////
////                               success(data)
////
////                           }
////
////                }else{
////                    failure(err)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
////    class func setFave(type:Int,ref_id:Int,success :   @escaping (_ response : Bool)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let params = [
////              "ref_id" : ref_id,
////              "type":type
////              ] as [String : Any]
////        ApiClient.sendRequestWithJsonContacts(path: "api/favourites/toggle", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = "error"
////
////            if let value = dict["status"] as? Dictionary<String, AnyObject>{
////
////                if value["status"] as? String == "success" {
////
////             success(true)
////
////                }else{
////                    failure(msg)
////
////                }
////
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." ,isRequireToken: true)
////    }
////
//
////class func getParentsInfo(success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/parent_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let item = userOB(dictionary:value)
////
////                success(item)
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getNotiCounter(parentId:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentId
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "ParentAPI/countNotification_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let cnt = value["count"] as? String
////
////                success(cnt ?? "")
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getFeeInof(success :   @escaping (_ response : feeOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "HomeAPI/fees_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let item = feeOB(dictionary:value)
////
////                success(item)
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////
////class func getSoicalLinks(success :   @escaping (_ response : [linkOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "HomeAPI/social_links_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            var data: [linkOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = linkOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getAboutInfo(success :   @escaping (_ response : aboutOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "HomeAPI/about_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let item = aboutOB(dictionary:value)
////
////                success(item)
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getTeacherInfo(success :   @escaping (_ response : teacherDataOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "HomeAPI/teacher_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let item = teacherDataOB(dictionary:value)
////
////                success(item)
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func updateParentInfo(parentId:Int,profession:String,password:String,name:String,phone:String,jawwal:String,email:String,address:String,relative_relation:String,profileImg:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////    let params = [
////        "token":token!,
////        "parent_id":"\(parentId)",
////        "profession":profession,
////        "name":name,
////        "phone":phone,
////        "jawwal":jawwal,
////        "email":email,
////        "password":password,
////        "address":address,
////        "relative_relation":relative_relation,
////        "userfile":"",
////        ] as [String : Any]
////
////
////
////    ApiClient.sendRequestWithImage(path: "https://timetolearnsa.com/parentAPI/parent_update_post", success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }             }, failure: { (err) in
////            failure(err.errorDescription)
////
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: profileImg,imageKeyName: "image", fileName: imageName, params: params, isRequireHeader: false)
////}
////
////class func addNewStudent(parentId:Int,birthday:String,sex:String,class_id:String,student_code:String,name:String,year:String,imgPassport:UIImage,imgCertify:UIImage,imgGenarl:UIImage,imgID:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////
////    let params = [
////        "token":token!,
////        "name":name,
////        "student_code":student_code,
////        "birthday":birthday,
////        "sex":"male",
////        "class_id":class_id,
////        "year":year,
////        "img_ssn":"",
////        "img_passport":"",
////        "img_vaccination_certificate":"",
////        "img_general":"",
////        "parent_id":"\(parentId)"
////        ] as [String : Any]
////
////
////
////    ApiClient.sendRequestWithMutliImage(path: "https://timetolearnsa.com/parentAPI/add_student", success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////        let status = dict.value(forKey: "status") as? String ?? ""
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == "1"{
////            print(status)
////
////
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }             }, failure: { (err) in
////            failure(err.errorDescription)
////
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?",imgID: imgID,imgPassport: imgPassport,imgCertify: imgCertify,imgMedical: imgGenarl,imgIDKeyName: "img_ssn",imgPassportKeyName: "img_passport",imgCertifyKeyName: "img_vaccination_certificate",imgMedcalKeyName: "img_general", fileName: imageName, params: params, isRequireHeader: false)
////}
////
////class func updateStudentInfo(parentId:Int,studentId:Int,pass:String,phone:String,profileImg:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////
////    let params = [
////        "token":token!,
////        "student_id" : "\(studentId)",
////        "password":pass,
////        "phone":phone,
////        "parent_id":"\(parentId)"
////        ] as [String : Any]
////
////
////
////    ApiClient.sendRequestWithImage(path: "https://timetolearnsa.com/parentAPI/student_update_post", success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }             }, failure: { (err) in
////            failure(err.errorDescription)
////
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: profileImg,imageKeyName: "image", fileName: imageName, params: params, isRequireHeader: false)
////}
////
////
////class func getStudentMatrial(parentID:Int,studentId:Int,success :   @escaping (_ response : [matOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentId
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/study_material_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [matOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = matOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getStudentsList(parentID:Int,success :   @escaping (_ response : [studentOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/student_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [studentOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = studentOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getEventList(parentID:Int,success :   @escaping (_ response : [eventsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/notices_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [eventsOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = eventsOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getLessons(parentID:Int,studentID:Int,subjectId:Int,success :   @escaping (_ response : [lessonsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "subject_id":subjectId
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "ParentAPI/lesson_details_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [lessonsOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = lessonsOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getSubjects(parentID:Int,student:String,success :   @escaping (_ response : [subjOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":"\(parentID)",
////        "student_id":student
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "ParentAPI/lessons_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [subjOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = subjOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////
////class func restPass(email:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "email" : email
////        ] as [String : Any]
////
////    ApiClient.sendRequest(path: "auth/forget_password_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getWeekPlan(parentID:Int,studentID:Int,success :   @escaping (_ response : [weekOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/weekly_plan_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [weekOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = weekOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getNoti(parentID:Int,success :   @escaping (_ response : [NotiOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":"\(parentID)"] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "ParentAPI/notification_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [NotiOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = NotiOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getWeekPlanDet(parentID:Int,studentID:Int,success :   @escaping (_ response : [weekOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/weekly_plan_archieve_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [weekOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = weekOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getTable(parentID:Int,studentID:Int,success :   @escaping (_ response : [planOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/class_routine_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [planOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = planOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////
////class func getActivityList(success :   @escaping (_ response : [activityOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "homeAPI/noticeboard_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [activityOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = activityOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getGalaryDet(id:String,success :  @escaping (_ response : [galaryOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////    let params = [
////        "frontend_gallery_id" : id
////        ] as [String : Any]
////
////    ApiClient.sendRequest(path: "homeAPI/gallery_details_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [galaryOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = galaryOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getMyPhoto(success :   @escaping (_ response : [galaryOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////    ApiClient.sendRequest(path: "homeAPI/gallery_post", parameters: [:], success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [galaryOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = galaryOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getMessageList(parentID:Int,success :   @escaping (_ response : [msgOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/message_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [msgOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = msgOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getReciveList(parentID:String,studentId:String,success :   @escaping (_ response : [rciverOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentId
////
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/reciver_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [rciverOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = rciverOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////
////class func sendMsg(name:String,email:String,phone:String,msg:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////    let params = [
////        "full_name":name,
////        "email":email,
////        "phone":phone,
////        "message":msg
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "homeAPI/send_msg_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func sendChatMsg(title:String,loginTypeRecive:String,msg:String,logTypesender:String,parent_id:String,reciver:String,attchedImag:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////    let params = [
////        "token":token!,
////        "title":title,
////        "login_type_reciever":loginTypeRecive,
////        "login_type_sender":logTypesender,
////        "parent_id":"\(parent_id)",
////        "receiver":reciver,
////        "message":msg
////
////        ] as [String : Any]
////
////    ApiClient.sendRequestWithImage(path: "https://timetolearnsa.com/parentAPI/send_msg_post", success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }             }, failure: { (err) in
////            failure(err.errorDescription)
////
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: attchedImag,imageKeyName: "attached_file_on_messaging", fileName: imageName, params: params, isRequireHeader: false)
////}
////
////class func newRegister(student_code:String,name:String,id_no:String,name_father:String,email_father:String,phone_father:String,relative_relation:String,jawwal:String,birthday:String,sex:String,address:String,phone:String,class_id:String,year:String,imgPassport:UIImage,imgCertify:UIImage,imgGenarl:UIImage,imgID:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////    let params = [
////        "student_code":student_code,
////        "name":name,
////        "id_no":id_no,
////        "name_father":name_father,
////        "email_father":email_father,
////        "phone_father":phone_father,
////        "relative_relation":relative_relation,
////        "jawwal":jawwal,
////        "birthday":birthday,
////        "sex":sex,
////        "address":address,
////        "phone":phone,
////        "class_id":class_id,
////        "year":year
////        ] as [String : Any]
////
////
////    ApiClient.sendRequestWithMutliImage(path: "https://timetolearnsa.com/auth/add_request", success: { (response) in
////
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? String ?? ""
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == "1"{
////            print(status)
////
////
////            success(msg)
////
////
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    } , httpMethod: .post, shouldShowProgress: false, progressMsg: "T##String?",imgID: imgID,imgPassport: imgPassport,imgCertify: imgCertify,imgMedical: imgGenarl,imgIDKeyName: "img_ssn",imgPassportKeyName: "img_passport",imgCertifyKeyName: "img_vaccination_certificate",imgMedcalKeyName: "img_general", fileName: imageName, params: params, isRequireHeader: false)
////}
////
////
////class func getMessageDet(parentID:Int,Msgcode:String,success :   @escaping (_ response : [msgOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "message_thread_code":Msgcode
////        ] as [String : Any]
////
////
////
////    ApiClient.sendRequest(path: "parentAPI/message_details_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [msgOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = msgOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func markMsgRead(parentID:Int,Msgcode:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "message_thread_code":Msgcode
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/update_message_read_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func replyMasg(parentID:Int,Msgcode:String,loginType:String,message:String,attchedFile:Data,attchedImag:UIImage,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////
////    let paramss = [
////        "token" : token!,
////        "parent_id":"\(parentID)",
////        "message_thread_code":Msgcode,
////        "login_type":loginType,
////        "message":message,
////        "attached_file_on_messaging":""] as [String : Any]
////
////
////    ApiClient.sendRequestWithImage(path: "https://timetolearnsa.com/parentAPI/send_reply_post", success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////
////            success(msg)
////
////
////        }else{
////            failure(msg)
////
////        }             }, failure: { (err) in
////            failure(err.errorDescription)
////
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: attchedImag,imageKeyName: "attached_file_on_messaging", fileName: imageName, params: paramss, isRequireHeader: false)
////}
////
////
////
////
////
////class func getDialyReport(parentID:Int,studentId:Int,success :   @escaping (_ response : [reportOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentId
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/daily_report_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status  == true{
////            print(status)
////
////            var data: [reportOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = reportOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////
////class func getDashBoardData(studentID:Int,parentID:Int,success :   @escaping (_ response : dashBoardOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/dashboard_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////                let item = dashBoardOB(dictionary:value)
////
////                success(item)
////            }
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func getPayment(studentID:Int,parentID:Int,success :   @escaping (_ response : [paymentOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/payments_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            print(status)
////
////            var data: [paymentOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = paymentOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
////class func reportDet(studentID:Int,parentID:Int,reportId:Int,success :   @escaping (_ response : [reportOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID,
////        "evaluation_id":reportId
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/daily_report_details_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            print(status)
////
////            var data: [reportOB] = []
////            if let value = dict["data"] as? Dictionary<String, AnyObject> {
////
////
////                if let value2 = value["daily_report"] as? Array<Dictionary<String, AnyObject>>  {
////
////                    for itemDic in value2 {
////                        let item = reportOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////                }
////
////
////
////            }
////
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////class func getMyPhoto(studentID:Int,parentID:Int,success :   @escaping (_ response : [studentOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    let token =  UserDefaults.standard.string(forKey: "token")
////
////    let params = [
////        "token" : token!,
////        "parent_id":parentID,
////        "student_id":studentID
////        ] as [String : Any]
////
////
////    ApiClient.sendRequest(path: "parentAPI/gallery_student_post", parameters: params, success: { (response) in
////        let dict = response as? NSDictionary ?? [:]
////
////        let status = dict.value(forKey: "status") as? Bool ?? false
////        let msg = dict.value(forKey: "message") as? String ?? ""
////
////        if status == true{
////            print(status)
////
////            var data: [studentOB] = []
////            if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                    let item = studentOB(dictionary:itemDic)
////                    data.append(item)
////                }
////
////                success(data)
////
////            }
////
////        }else{
////            failure(msg)
////        }
////
////
////    }, failure: { (err) in
////        failure(err.errorDescription)
////    }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login..." )
////}
////
////
//
//
////
////    class func ChangePass(currentPass : String ,password:String, success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        let params = [
////            "current_password": currentPass,
////            "password":password
////            ] as [String : Any]
////
////
////        ApiClient.sendRequest(path: "change_password", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////
////            if status == true{
////                success(msg)
//////                 success(token)
////            }else{
////                failure(msg)
////            }
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login...",isRequireToken: true)
////    }
////
////     class func addAdress(name:String, mobile:Int,city_id: Int,street: String,flat: Int,floor:Int,building:Int,area_id:Int,lat:Double,lng:Double,note: String, success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////            let params = [
////                "name": name,
////                "mobile":mobile,
////                "city_id":city_id,
////                "street":street,
////                "building":building,
////                "floor":floor,
////                "flat":flat,
////                "lat":lat,
////                "lng":lng,
////                "note":note,
////                "area_id":area_id
////                ] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "add_address", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////
////                let status = dict.value(forKey: "status") as? Bool ?? false
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////
////                if status == true{
////                    success(msg)
////    //                 success(token)
////                }else{
////                    failure(msg)
////                }
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "login...",isRequireToken: true)
////        }
////
////
////    class func UserRegister(username : String  , email : String,gendar:Int , password : String,passwordConfirm : String ,mobile:Int, success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let params = [
////            "name" : username ,
////            "email" : email ,
////            "password" : password,
////            "mobile":mobile,
////            "token":123456,
////            "device":"ios",
////            "code":1111
////            ] as [String : Any]
////
////        ApiClient.sendRequest(path: "Register", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "success") as? String ?? ""
////            let msg = dict.value(forKey: "errors") as? String ?? ""
////
////            if status == "success"{
////
////                let token = dict.value(forKey: "remember_token") as? String ?? ""
////                //                success(token)
////                //                success(dict)
////                //
////            }else{
////                failure(msg)
////            }
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: false, progressMsg: "register...")
////    }
////
////    class func GetPayment(success :   @escaping (_ response : [ordersOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////           ApiClient.sendRequest(path: "payment_methods", parameters: [:], success: { (response) in
////                  let dict = response as? NSDictionary ?? [:]
////                  let status = dict.value(forKey: "status") as? Bool ?? false
////                  let msg = dict.value(forKey: "message") as? String ?? ""
////
////                  if status  == true{
////                      print(status)
////
////                         var data: [ordersOB] = []
////                                  if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                                      for itemDic in value {
////                                          let item = ordersOB(dictionary:itemDic)
////                                          data.append(item)
////                                      }
////
////                                      success(data)
////
////                                  }
////
////                  }else{
////                      failure(msg)
////
////                  }
////
////
////
////              }, failure: { (err) in
////                  failure(err.errorDescription)
////              }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////          }
////
////
////    class func GetOrders(status:Int,success :   @escaping (_ response : [ordersOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        let params = [
////                "status" : status
////                ] as [String : Any]
////
////           ApiClient.sendRequest(path: "orders", parameters: params, success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == true{
////                   print(status)
////
////                      var data: [ordersOB] = []
////                               if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                                   for itemDic in value {
////                                       let item = ordersOB(dictionary:itemDic)
////                                       data.append(item)
////                                   }
////
////                                   success(data)
////
////                               }
////
////               }else{
////                   failure(msg)
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////       }
////
////
////
////
////
//
//
////
////    class func GetProfile(success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////           ApiClient.sendRequest(path: "profile", parameters: [:], success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == true{
////                   print(status)
////
////
////                   if let value = dict["items"] as? Dictionary<String, AnyObject> {
////                       let item = userOB(dictionary:value)
////                       success(item)
////                   }
////
////               }else{
////                   failure(msg)
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////       }
////
////
////    class func GetData(success :   @escaping (_ response : HomeOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "home", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////
////                if let value = dict["items"] as? Dictionary<String, AnyObject> {
////                    let item = HomeOB(dictionary:value)
////                    success(item)
////                }
////
////            }else{
////                failure(msg)
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////
////
////
////
////    class func GetExlusiveProduct(success :   @escaping (_ response : [exclusiveProductOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "recommend_products", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [exclusiveProductOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = exclusiveProductOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////
////    class func GetProductData(catId:Int,success :   @escaping (_ response : [sectionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "sections/\(catId)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [sectionsOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = sectionsOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: false)
////    }
////
////
////
////    class func GetCart(success :   @escaping (_ response : [cartOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////          ApiClient.sendRequest(path: "my_cart", parameters: [:], success: { (response) in
////              let dict = response as? NSDictionary ?? [:]
////              let status = dict.value(forKey: "status") as? Bool ?? false
////              let msg = dict.value(forKey: "message") as? String ?? ""
////
////              if status  == true{
////                  print(status)
////
////                  var data: [cartOB] = []
////                  if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                      for itemDic in value {
////                          let item = cartOB(dictionary:itemDic)
////                          data.append(item)
////                      }
////
////                      success(data)
////
////                  }
////
////
////              }else{
////                  failure(msg)
////
////
////              }
////
////
////
////          }, failure: { (err) in
////              failure(err.errorDescription)
////          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////      }
////
////    class func payMeth(addressId:Int,payMethId:Int,success :   @escaping (_ response : Bool)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////              let params = [
////              "address_id" : addressId,
////              "payment_method_id":payMethId
////              ] as [String : Any]
////
////
////
////               ApiClient.sendRequest(path: "check_out", parameters: params, success: { (response) in
////                   let dict = response as? NSDictionary ?? [:]
////                   let status = dict.value(forKey: "status") as? Bool ?? false
////                   let msg = dict.value(forKey: "message") as? String ?? ""
////
////                   if status  == true{
////
////                        success(status)
////
////                   }else{
////                       failure(msg)
////
////
////                   }
////
////
////
////               }, failure: { (err) in
////                   failure(err.errorDescription)
////               }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////           }
////
////
////
////    class func removeToCart(proId:Int,quntNo:Int,success :   @escaping (_ response : Int)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////
////           let params = [
////           "product_id" : proId
////           ] as [String : Any]
////
////
////
////            ApiClient.sendRequest(path: "delete_cart", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////                let status = dict.value(forKey: "status") as? Bool ?? false
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////                if status  == true{
////                    print(status)
////
////                    var data: [productOB] = []
////                    if let value = dict["items"] as? Int {
////
////                        success(value)
////
////                    }
////
////
////                }else{
////                    failure(msg)
////
////
////                }
////
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////        }
////
////    class func addtToCart(proId:Int,quntNo:Int,success :   @escaping (_ response : Int)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////
////        let params = [
////        "product_id" : proId ,
////        "quantity" : quntNo ,
////        ] as [String : Any]
////
////
////
////         ApiClient.sendRequest(path: "add_cart", parameters: params, success: { (response) in
////             let dict = response as? NSDictionary ?? [:]
////             let status = dict.value(forKey: "status") as? Bool ?? false
////             let msg = dict.value(forKey: "message") as? String ?? ""
////
////             if status  == true{
////                 print(status)
////
////                 var data: [productOB] = []
////                 if let value = dict["items"] as? Int {
////
////                     success(value)
////
////                 }
////
////
////             }else{
////                 failure(msg)
////
////
////             }
////
////
////
////         }, failure: { (err) in
////             failure(err.errorDescription)
////         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////     }
////
////
////    class func GetCity(id:Int,success :   @escaping (_ response : [contryOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////          ApiClient.sendRequest(path: "countries/\(id)", parameters: [:], success: { (response) in
////                  let dict = response as? NSDictionary ?? [:]
////                  let status = dict.value(forKey: "status") as? Bool ?? false
////                  let msg = dict.value(forKey: "message") as? String ?? ""
////
////                  if status  == true{
////                      print(status)
////
////                      var data: [contryOB] = []
////                      if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                          for itemDic in value {
////                              let item = contryOB(dictionary:itemDic)
////                              data.append(item)
////                          }
////
////                          success(data)
////
////                      }
////
////
////                  }else{
////                      failure(msg)
////
////
////                  }
////
////
////
////              }, failure: { (err) in
////                  failure(err.errorDescription)
////              }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////    class func GetContriers(success :   @escaping (_ response : [contryOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////            ApiClient.sendRequest(path: "countries", parameters: [:], success: { (response) in
////                    let dict = response as? NSDictionary ?? [:]
////                    let status = dict.value(forKey: "status") as? Bool ?? false
////                    let msg = dict.value(forKey: "message") as? String ?? ""
////
////                    if status  == true{
////                        print(status)
////
////                        var data: [contryOB] = []
////                        if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                            for itemDic in value {
////                                let item = contryOB(dictionary:itemDic)
////                                data.append(item)
////                            }
////
////                            success(data)
////
////                        }
////
////
////                    }else{
////                        failure(msg)
////
////
////                    }
////
////
////
////                }, failure: { (err) in
////                    failure(err.errorDescription)
////                }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////      }
////
////    class func GetAdress(success :   @escaping (_ response : [AdressOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////          ApiClient.sendRequest(path: "addresses", parameters: [:], success: { (response) in
////                  let dict = response as? NSDictionary ?? [:]
////                  let status = dict.value(forKey: "status") as? Bool ?? false
////                  let msg = dict.value(forKey: "message") as? String ?? ""
////
////                  if status  == true{
////                      print(status)
////
////                      var data: [AdressOB] = []
////                      if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                          for itemDic in value {
////                              let item = AdressOB(dictionary:itemDic)
////                              data.append(item)
////                          }
////
////                          success(data)
////
////                      }
////
////
////                  }else{
////                      failure(msg)
////
////
////                  }
////
////
////
////              }, failure: { (err) in
////                  failure(err.errorDescription)
////              }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////    class func GetSubSection(catId:Int,success :   @escaping (_ response : sectionsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "sub_sections/\(catId)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                if let value = dict["items"] as? Dictionary<String, AnyObject> {
////
////                        let item = sectionsOB(dictionary:value)
////
////
////                    success(item)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: false)
////    }
////
////
////
////    class func GetProductDet(id:Int,success :   @escaping (_ response : itemOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        ApiClient.sendRequest(path: "product_details/\(id)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                if let value = dict["items"] as? Dictionary<String, AnyObject>{
////
////
////                    let item = itemOB(dictionary:value)
////
////                    success(item)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////
////
////
////    class func GetCatDet(id:Int,success :   @escaping (_ response : [sectionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "categories/\(id)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [sectionsOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = sectionsOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////    class func GetCatSection(id:Int,success :   @escaping (_ response : [sectionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "categories/\(id)", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [sectionsOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = sectionsOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////    class func GetSubSectionData(id:Int,success :   @escaping (_ response : sectionsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////           ApiClient.sendRequest(path: "sub_sections/\(id)", parameters: [:], success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "status") as? Bool ?? false
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == true{
////                   print(status)
////
////                   if let value = dict["items"] as? Dictionary<String, AnyObject> {
////
////                           let item = sectionsOB(dictionary:value)
////
////
////                       success(item)
////
////                   }
////
////
////               }else{
////                   failure(msg)
////
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////       }
////
////    class func GetNewSections(success :   @escaping (_ response : [sectionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "sections", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [sectionsOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = sectionsOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////
////
////    class func GetBrands(success :   @escaping (_ response : [sectionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        ApiClient.sendRequest(path: "brands", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "status") as? Bool ?? false
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == true{
////                print(status)
////
////                var data: [sectionsOB] = []
////                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = sectionsOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////
////                    success(data)
////
////                }
////
////
////            }else{
////                failure(msg)
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    }
////
////
//
//
//
////
////    //ShowProfile
////
////    //    class func ShowProgfile( success :   @escaping (_ response : ISData)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //
////    //
////    //
////    //
////    //
////    //        ApiClient.sendRequest(path: "student", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //
////    //            if(status){
////    //
////    //                success(InfoUser(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //                                success(dict)
////    //
////    //
////    //
////    //
////    //            }else{
////    //                failure(msg)
////    //            }
////    //
////    //
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Edting...",isRequireToken: true )
////    //    }
////    //
////
////
////
////    //
////    //
////
////
////    //GetSlider
////
////
////
////    class func GetGalaeryDet(Id:Int,success :   @escaping (_ response : HomeOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////        let token = UserDefaults.standard.string(forKey: "token")
////
////          ApiClient.sendRequest(path: "project/\(Id)?token=\(token ?? "")", parameters: [:], success: { (response) in
////              let dict = response as? NSDictionary ?? [:]
////              let status = dict.value(forKey: "success") as? String ?? ""
////              let msg = dict.value(forKey: "message") as? String ?? ""
////
////              if status  == "success"{
////                  print(status)
////
////
////                  var data: [HomeOB] = []
////                  if let value = dict["data"] as? Dictionary<String, AnyObject> {
////
////                          let item = HomeOB(dictionary:value)
////
////                success(item)
////
////                  }
////
////              }else{
////                  failure(msg)
////
////
////
////
////
////
////
////
////              }
////
////
////
////          }, failure: { (err) in
////              failure(err.errorDescription)
////          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////      }
////
////    class func GetHome(success :   @escaping (_ response : [HomeOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////
////
////        let token = UserDefaults.standard.string(forKey: "token")
////
////        ApiClient.sendRequest(path: "homePage?token=\(token ?? "")", parameters: [:], success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "success") as? String ?? ""
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == "success"{
////                print(status)
////
////
////                var data: [HomeOB] = []
////                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                    for itemDic in value {
////                        let item = HomeOB(dictionary:itemDic)
////                        data.append(item)
////                    }
////                }
////
////
////                success(data)
////
////            }else{
////                failure(msg)
////
////
////
////
////
////
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    }
////
////
////
////    class func GetUserProfile(userId:Int,success :   @escaping (_ response : userProOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////         let token = UserDefaults.standard.string(forKey: "token")
////        let params = [
////                 "token" : token! ] as [String : Any]
////
////
////        ApiClient.sendRequest(path: "user_profile/\(userId)", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "success") as? String ?? ""
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == "success"{
////                print(status)
////
////
////                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////
////            let item = userProOB(dictionary:value)
////                        success(item)
////
////                }
////
////
////
////            }else{
////                failure(msg)
////
////
////
////
////
////
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////    }
////
////
////
////
////
////    class func postFave(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////         let token = UserDefaults.standard.string(forKey: "token")
////
////
////        let params = [
////                 "token" : token!,
////            "id":id] as [String : Any]
////
////
////        ApiClient.sendRequest(path: "favorite", parameters: params, success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let status = dict.value(forKey: "success") as? String ?? ""
////            let msg = dict.value(forKey: "message") as? String ?? ""
////
////            if status  == "success"{
////                print(status)
////
////
//////                if let value = dict["data"] as? Dictionary<String, AnyObject>{
//////
//////
//////            let item = userProOB(dictionary:value)
////                        success("success")
//////
//////                }
////
////
////
////            }else{
////                failure(msg)
////
////
////
////
////
////
////
////
////            }
////
////
////
////        }, failure: { (err) in
////            failure(err.errorDescription)
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////    }
////
////    class func EditGalary(id:Int,project_name:String,disc:String,cover_image:UIImage,images:[UIImage] , success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////         let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////         let token = UserDefaults.standard.string(forKey: "token")
////
////
////
////
////         let paramss = [
////             "token" : token,
////             "project_name" : project_name,
////             "disc" : disc,
////             "cover_image" : "",
////             "images[]": "",
////             "gallery_id":"\(id)"] as [String : Any]
////
////
////         ApiClient.sendRequestWithImage(path: "editGallery", success: { (response) in
////             let dict = response as? NSDictionary ?? [:]
////             let state = dict.value(forKey: "success") as? String ?? ""
////             let msg = dict.value(forKey: "filename") as? String ?? ""
////
////
////             if  state  == "success"{
////                 success(dict)
////
////             }else{
////                 failure(msg)
////
////             }
////         }, failure: { (err) in
////             failure(err.errorDescription)
////
////         }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: cover_image, Imges: images,imageKeyName: "img", fileName: imageName, params: paramss, isRequireHeader: false,isEdit: true)
////     }
////
////
////
////
////
////
////
////    class func delete(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////             let token = UserDefaults.standard.string(forKey: "token")
////
////
////            let params = [
////                     "token" : token!,
////                "gallery_id":id] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "deleteGallery", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////                let status = dict.value(forKey: "success") as? String ?? ""
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////                if status  == "success"{
////                    print(status)
////
////
////    //                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////    //
////    //
////    //            let item = userProOB(dictionary:value)
////                            success("success")
////    //
////    //                }
////
////
////
////                }else{
////                    failure(msg)
////
////
////
////
////
////
////
////
////                }
////
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////        }
////
////
////
////
////
////
////
////
////
////
////
////    class func UnfollowUser(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////               let token = UserDefaults.standard.string(forKey: "token")
////
////
////              let params = [
////                  "token" : token!,
////                  "user_id":id] as [String : Any]
////
////
////              ApiClient.sendRequest(path: "userUnFollowing", parameters: params, success: { (response) in
////                  let dict = response as? NSDictionary ?? [:]
////                  let status = dict.value(forKey: "success") as? String ?? ""
////                  let msg = dict.value(forKey: "message") as? String ?? ""
////
////                  if status  == "success"{
////                      print(status)
////
////
////      //                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////      //
////      //
////      //            let item = userProOB(dictionary:value)
////                              success("success")
////      //
////      //                }
////
////
////
////                  }else{
////                      failure(msg)
////
////
////
////
////
////
////
////
////                  }
////
////
////
////              }, failure: { (err) in
////                  failure(err.errorDescription)
////              }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////          }
////
////
////
////    class func followUser(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////             let token = UserDefaults.standard.string(forKey: "token")
////
////
////            let params = [
////                "token" : token!,
////                "user_id":id] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "userFollowing", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////                let status = dict.value(forKey: "success") as? String ?? ""
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////                if status  == "success"{
////                    print(status)
////
////
////    //                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////    //
////    //
////    //            let item = userProOB(dictionary:value)
////                            success("success")
////    //
////    //                }
////
////
////
////                }else{
////                    failure(msg)
////
////
////
////
////
////
////
////
////                }
////
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////        }
////
////    class func postLike(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////             let token = UserDefaults.standard.string(forKey: "token")
////
////
////            let params = [
////                "token" : token!,
////                "gallery_id":id] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "Like", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////                let status = dict.value(forKey: "success") as? String ?? ""
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////                if status  == "success"{
////                    print(status)
////
////
////    //                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////    //
////    //
////    //            let item = userProOB(dictionary:value)
////                            success("success")
////    //
////    //                }
////
////
////
////                }else{
////                    failure(msg)
////
////
////
////
////
////
////
////
////                }
////
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////        }
////
////    class func postDisLike(id:Int,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////             let token = UserDefaults.standard.string(forKey: "token")
////
////
////            let params = [
////                     "token" : token!,
////                "gallery_id":id] as [String : Any]
////
////
////            ApiClient.sendRequest(path: "unLike", parameters: params, success: { (response) in
////                let dict = response as? NSDictionary ?? [:]
////                let status = dict.value(forKey: "success") as? String ?? ""
////                let msg = dict.value(forKey: "message") as? String ?? ""
////
////                if status  == "success"{
////                    print(status)
////
////
////    //                if let value = dict["data"] as? Dictionary<String, AnyObject>{
////    //
////    //
////    //            let item = userProOB(dictionary:value)
////                            success("success")
////    //
////    //                }
////
////
////
////                }else{
////                    failure(msg)
////
////
////
////
////
////
////
////
////                }
////
////
////
////            }, failure: { (err) in
////                failure(err.errorDescription)
////            }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////        }
////
////
////
////    class func GetMyProfile(success :   @escaping (_ response : userOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////            let token = UserDefaults.standard.string(forKey: "token")
////           let params = [
////                    "token" : token! ] as [String : Any]
////
////
////           ApiClient.sendRequest(path: "profile", parameters: params, success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "success") as? String ?? ""
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == "success"{
////                   print(status)
////
////
////                   if let value = dict["data"] as? Dictionary<String, AnyObject>{
////
////
////               let item = userOB(dictionary:value)
////                           success(item)
////
////                   }
////
////
////
////               }else{
////                   failure(msg)
////
////
////
////
////
////
////
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////       }
////
////
////
////    class func GetCountries(success :   @escaping (_ response : [CountriesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////            let token = UserDefaults.standard.string(forKey: "token")
////
////
////           ApiClient.sendRequest(path: "countries", parameters:  [:], success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "success") as? String ?? ""
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == "success"{
////                   print(status)
////
////
////
////               var data: [CountriesOB] = []
////                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                                   for itemDic in value {
////                                       let item = CountriesOB(dictionary:itemDic)
////                                       data.append(item)
////                                   }
////
////
////                    success(data)
////
////                               }
////
////
////               }else{
////                   failure(msg)
////
////
////
////
////
////
////
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////       }
////
////
////
////    class func GetCity(countriesId:Int,success :   @escaping (_ response : [CityOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////          let params = [
////            "country_id" : countriesId ] as [String : Any]
////
////           ApiClient.sendRequest(path: "cityGetCountry", parameters: params, success: { (response) in
////               let dict = response as? NSDictionary ?? [:]
////               let status = dict.value(forKey: "success") as? String ?? ""
////               let msg = dict.value(forKey: "message") as? String ?? ""
////
////               if status  == "success"{
////                   print(status)
////
////                   var data: [CityOB] = []
////                                 if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////             for itemDic in value {
////                    let item = CityOB(dictionary:itemDic)
////                                                        data.append(item)
////                                                    }
////
////
////                                     success(data)
////
////                                                }
////
////
////
////               }else{
////                   failure(msg)
////
////
////
////
////
////
////
////
////               }
////
////
////
////           }, failure: { (err) in
////               failure(err.errorDescription)
////           }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////       }
////
////
////
////
////
////    class func GetFav(success :   @escaping (_ response : [HomeOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let token = UserDefaults.standard.string(forKey: "token")
////
////
////             let params = [
////               "token" : "\(token!)" ] as [String : Any]
////
////              ApiClient.sendRequest(path: "favorites", parameters: params, success: { (response) in
////                  let dict = response as? NSDictionary ?? [:]
////                  let status = dict.value(forKey: "success") as? String ?? ""
////                  let msg = dict.value(forKey: "message") as? String ?? ""
////
////                  if status  == "success"{
////                      print(status)
////
////                      var data: [HomeOB] = []
////                                    if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////
////                for itemDic in value {
////                       let item = HomeOB(dictionary:itemDic)
////                                                           data.append(item)
////                                                       }
////
////
////                        success(data)
////
////                                                   }
////
////
////
////                  }else{
////                      failure(msg)
////
////
////
////
////
////
////
////
////                  }
////
////
////
////              }, failure: { (err) in
////                  failure(err.errorDescription)
////              }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Cities...")
////          }
////
////
////
////    class func AddGalary(project_name:String,disc:String,cover_image:UIImage,images:[UIImage] , success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////        let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////        let token = UserDefaults.standard.string(forKey: "token")
////
////
////
////
////        let paramss = [
////            "token" : token,
////            "project_name" : project_name,
////            "disc" : disc,
////            "cover_image" : "",
////            "images[]": "" ] as [String : Any]
////
////
////        ApiClient.sendRequestWithImage(path: "addGallery", success: { (response) in
////            let dict = response as? NSDictionary ?? [:]
////            let state = dict.value(forKey: "success") as? String ?? ""
////            let msg = dict.value(forKey: "filename") as? String ?? ""
////
////
////            if  state  == "success"{
////                success(dict)
////
////            }else{
////                failure(msg)
////
////            }
////        }, failure: { (err) in
////            failure(err.errorDescription)
////
////        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: cover_image, Imges: images,imageKeyName: "img", fileName: imageName, params: paramss, isRequireHeader: false)
////    }
////
////
////
////    class func EditPro(image:UIImage,name:String, mobile:Int,gender:Int,bio:String,city_Id:Int,country_Id:Int,job:String,behance:String,fcb:String,twi:String,
////        insta:String,success :   @escaping (_ response : String)  -> Void , failure :  @escaping (_ err : String) -> Void){
////
////          let imageName = "img-\(CACurrentMediaTime()).png"
////
////
////          let token = UserDefaults.standard.string(forKey: "token")
////
////
////
////          let paramss = [
////              "token" : token,
////              "image" : "",
////              "name":name,
////              "city_Id" : "2",
////              "country_Id" : "\(country_Id)",
////              "bio":bio,
////              "job":job,
////            "facebook":fcb,
////            "instagram":insta,"twitter":twi,"behance":behance] as [String : Any]
////
////
////          ApiClient.sendRequestWithImage(path: "update_profile", success: { (response) in
////              let dict = response as? NSDictionary ?? [:]
////              let state = dict.value(forKey: "success") as? String ?? ""
////              let msg = dict.value(forKey: "message") as? String ?? ""
////
////
////              if  state  == "success"{
////
////
////                success(msg)
////
////
////              }else{
////                  failure(msg)
////
////              }
////          }, failure: { (err) in
////              failure(err.errorDescription)
////
////          }, httpMethod: .post, shouldShowProgress: true, progressMsg: "T##String?", Image: image, Imges: [],imageKeyName: "img", fileName: imageName, params: paramss, isRequireHeader: false,isPro: true)
////      }
////
////
////
////
////
////
////
////
////    //
////    //
////    //
////    //
////    //    //GetCienma
////    //
////
////
////    //    class func GetٍSlider(success :   @escaping (_ response : [postOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //          ApiClient.sendRequest(path: "top_posts", parameters: [:], success: { (response) in
////    //              let dict = response as? NSDictionary ?? [:]
////    //              let status = dict.value(forKey: "status") as? Bool ?? false
////    //              let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //              if (status) {
////    //                  print(status)
////    //                  var data: [postOB] = []
////    //                  if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                      for itemDic in value {
////    //                          let item = postOB(dictionary:itemDic)
////    //                          data.append(item)
////    //                      }
////    //                  }
////    //                  success(data)
////    //              }else{
////    //                  failure(msg)
////    //
////    //              }
////    //          }, failure: { (err) in
////    //              failure(err.errorDescription)
////    //          }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //      }
////    //
////    //    class func GetPosts(success :   @escaping (_ response : [postOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "posts", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [postOB] = []
////    //                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = postOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //    class func GetPostsDetials(id:Int,success :   @escaping (_ response : newsDetialsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "posts/\(id)", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //
////    //                if let value = dict["items"] as? Dictionary<String, AnyObject> {
////    //
////    //                    success(newsDetialsOB(dictionary: value ))
////    //
////    //
////    //                }
////    //
////    //
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //
////    //    class func GetCat(success :   @escaping (_ response : [catOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "categories", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [catOB] = []
////    //                if let value = dict["items"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = catOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //
////    //
////    //    //GetCorses
////    //    class func GetCoreses(success :   @escaping (_ response : [CoursesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "courses", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [CoursesOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = CoursesOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //    //GetTeacher
////    //    class func GetTeacher(success :   @escaping (_ response : [TeacherOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "teachers", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [TeacherOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = TeacherOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //    class func GetTeacherVideo(Id:Int,type:String,success :   @escaping (_ response : [TeacherVideosOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "\(type)/\(Id)/videos", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [TeacherVideosOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = TeacherVideosOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //    class func GetTeacherNotes(Id:Int,type:String,success :   @escaping (_ response : [NotesOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "\(type)/\(Id)/notes", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [NotesOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = NotesOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //
////    //    class func GetTeacherQu(Id:Int,type:String ,success :   @escaping (_ response : [quetionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "\(type)/\(Id)/qas", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [quetionsOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = quetionsOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //    class func GetCorseQs(Id:Int,success :   @escaping (_ response : [quetionsOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "teacher/\(Id)/qas", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [quetionsOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = quetionsOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //
////    //
////    //    class func GetTeacherCourse(Id:Int,type:String,success :   @escaping (_ response : [CinemaOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "\(type)/\(Id)/onlineVideos", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [CinemaOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = CinemaOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////
////    //    class func ِAddChalet(vendor_name : String , owner_name : String , phone : Int , location : String  , image : String , success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        let params = [
////    //            "vendor_name" : vendor_name ,
////    //            "owner_name" : owner_name ,
////    //            "phone" : phone ,
////    //            "location" : location ,
////    //            "image" : image
////    //
////    //            ] as [String : Any]
////    //
////    //        ApiClient.sendRequest(path: "add_request_chalet", parameters: params, success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if(status){
////    //
////    //                success(User_Register(dictionary: dict as! Dictionary<String, Any>))
////    //
////    //                success(dict)
////    //
////    //            }else{
////    //                failure(msg)
////    //            }
////    //
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "register...")
////    //    }
////
////
////
////    //    class func Activate(activation_code : String , ios_token : String , success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //        let params = [
////    //            "activation_code" : activation_code ,
////    //            "ios_token" : ios_token
////    //        ]
////    //
////    //        ApiClient.sendRequest(path: "user_activate", parameters: params , success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //            let token = dict.value(forKey: "access_token") as? String ?? ""
////    //
////    //            UserDefaults.standard.set(token, forKey: "userToken")
////    //
////    //
////    //
////    //
////    //
////    //            if (status) {
////    //                success(User_Activate(dictionary: dict as! Dictionary<String, Any>))
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "Adding...")
////    //    }
////    //
//
//
//
//
////    //    class func CitiesWithChalet(success :   @escaping (_ response : [Data_Cities_With_Chalet])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "cities_with_chalet", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [Data_Cities_With_Chalet] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = Data_Cities_With_Chalet(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "")
////    //    }
////    //
////    //
////    //
////    //    class func GetMyRev(state:Int,success :   @escaping (_ response : [MyReservationOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //        ApiClient.sendRequest(path: "get_order", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [MyReservationOB] = []
////    //                if let value = dict["data"] as? [Array<Dictionary<String, AnyObject>>] {
////    //
////    ////                    let value2 = value as? Array<Dictionary<String, AnyObject>>
////    //
////    //                   print(value)
////    //                    data.removeAll()
////    //                    for itemDic in value[state] {
////    //                        let item = MyReservationOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "",isRequireToken: true)
////    //    }
////    //
////    //
////    //    class func MapChalet(success :   @escaping (_ response : [Data_AllChaletOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "map_chalet", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [Data_AllChaletOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = Data_AllChaletOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...")
////    //    }
////    //
////    //    class func Chalet(id: Int,success :   @escaping (_ response : Data_Chalet)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "chalet/\(id)" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(InfoChalet(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Chalets...")
////    //    }
////    //
////    //    class func userData(success :   @escaping (_ response : DataProfile)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //        ApiClient.sendRequest(path: "user_profile", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(InfoUser(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "", isRequireToken: true)
////    //
////    //
////    //    }
////    //    class func UpdateuserData(first_name:String,lastName:String,success :   @escaping (_ response : DataProfile)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //        let params = [
////    //            "first_name" : first_name ,
////    //            "last_name" : lastName
////    //        ]
////    //
////    //        ApiClient.sendRequest(path: "user_update_profile", parameters: params, success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(InfoUser(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "", isRequireToken: true)
////    //
////    //
////    //    }
////    //
////    //    class func revChalet(vendor_id:Int,date:String,time:Int,type:Int,number_of_people:Int,price:Int,success :   @escaping (_ response : chaletRevDatesOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //        let params = [
////    //            "vendor_id" : vendor_id ,
////    //            "date" : date,
////    //            "time" : time,
////    //            "type" : type,
////    //            "number_of_people" : number_of_people,
////    //            "price" : price
////    //
////    //            ] as [String : Any]
////    //
////    //        ApiClient.sendRequest(path: "order", parameters: params, success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            PobViewREsult3.msg = msg
////    //            if (status) {
////    //                print(status)
////    //
////    //                print(status)
////    //                success(RevOB(dictionary: dict as! Dictionary<String, Any>).data)            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "", isRequireToken: true)
////    //
////    //
////    //    }
////    //
////    //
////    //    class func ChaletArea(success :   @escaping (_ response : [Data_Chaelt_Area])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "areas_by_city" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [Data_Chaelt_Area] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = Data_Chaelt_Area(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "")
////    //    }
////    //
////    //
////    //
////    //    class func Fetuers(success :   @escaping (_ response : characteristicsOB)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "characteristics" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(InfoCharacter(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "")
////    //    }
////    //
////    //
////    //
////    //
////    //
////    //
////    //
////    //
////    //
////    //
////    //    class func Cities(id: Int,success :   @escaping (_ response : Data_Cities_With_Chalet)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "cities/\(id)" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(InfoChaletCites(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Chalets...")
////    //    }
////    //
////
////    //
////    //    class func NotifcationApi(success :   @escaping (_ response : [NotifcationOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "notifications", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [NotifcationOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = NotifcationOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    //    }
////    //
////    //
////    //
////    //    class func getDayPrice(id:Int,dateStr: String,success :   @escaping (_ response : [Day_PriceOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "days_price/\(id)/\(dateStr)", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [Day_PriceOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = Day_PriceOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: true)
////    //    }
////    //
////    //
////    //
////    //
////    //    class func FilterData(dateStr:String,areaId:Int,priceOf:Int,priceTo:Int,rate:Int,fetuers: [Int],success :   @escaping (_ response : [ChaletOB])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //
////    //        var jsonString = "";
////    //
////    //        do {
////    //
////    //            let jsonData = try JSONSerialization.data(withJSONObject: fetuers, options: .prettyPrinted)
////    //            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
////    //
////    //        } catch {
////    //            print(error.localizedDescription)
////    //        }
////    //
////    //        let params = [
////    //            "date" : dateStr ,
////    //            "area_id" : areaId ,
////    //            "price_of" : priceOf ,
////    //            "price_to" : priceTo ,
////    //            "rate" : rate,
////    //            "characteristics" : jsonString
////    //
////    //
////    //            ] as [String : Any]
////    //
////    //        print("para",params)
////    //        ApiClient.sendRequest(path: "filter_chalet" , parameters: params, success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [ChaletOB] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = ChaletOB(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .post, shouldShowProgress: true, progressMsg: "filter...")
////    //    }
////    //
////    //    func toJSonString(data : Any) -> String {
////    //
////    //        var jsonString = "";
////    //
////    //        do {
////    //
////    //            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
////    //            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
////    //
////    //        } catch {
////    //            print(error.localizedDescription)
////    //        }
////    //
////    //        return jsonString;
////    //    }
////    //
////    //
////    //
////    //
////    //
////    //       class func getDates(id: Int,success :   @escaping (_ response : RevDates)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "order_chalet/\(id)", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //
////    ////                let value = dict["data"] as! Dictionary<String, Any>
////    //                var data : RevDates!
////    //
////    //                if ((dict as? Dictionary<String, AnyObject>) != nil) {
////    //
////    //                    if let value =  dict["data"] as? Dictionary<String, AnyObject> {
////    //                        data = RevDates(dictionary: value)
////    //                    }
////    //                    if data != nil {
////    //                        success(data)
////    //
////    //                    }
////    ////                    success(InfoRevDataa(dictionary: dict as! Dictionary<String, AnyObject>).data)
////    //
////    //                }
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: false)
////    //    }
////    //
////    //    class func aboutApp(success :   @escaping (_ response : [PageData])  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "pages", parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                var data: [PageData] = []
////    //                if let value = dict["data"] as? Array<Dictionary<String, AnyObject>> {
////    //
////    //                    for itemDic in value {
////    //                        let item = PageData(dictionary:itemDic)
////    //                        data.append(item)
////    //                    }
////    //                }
////    //                success(data)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "Cities...",isRequireToken: false)
////    //    }
////    //
////    //    class func Page(success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "pages" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(Pages(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "pages...")
////    //    }
////    //
////    //    class func Settings(success :   @escaping (_ response : Any)  -> Void , failure :  @escaping (_ err : String) -> Void){
////    //
////    //        ApiClient.sendRequest(path: "settings" , parameters: [:], success: { (response) in
////    //            let dict = response as? NSDictionary ?? [:]
////    //            let status = dict.value(forKey: "status") as? Bool ?? false
////    //            let msg = dict.value(forKey: "message") as? String ?? ""
////    //
////    //            if (status) {
////    //                print(status)
////    //                success(Setting(dictionary: dict as! Dictionary<String, Any>).data)
////    //                //success(dict)
////    //            }else{
////    //                failure(msg)
////    //
////    //            }
////    //        }, failure: { (err) in
////    //            failure(err.errorDescription)
////    //        }, httpMethod: .get, shouldShowProgress: true, progressMsg: "settings...")
////    //    }
////
////}
////
//}
//protocol NoIntenetConnection {
//    func onInernetConnectInterrupt()
//    func onInvalidLogin()
//}
//
//extension String {
//var fixedArabicURL: String?  {
//       return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics
//           .union(CharacterSet.urlPathAllowed)
//           .union(CharacterSet.urlHostAllowed))
//   } }
