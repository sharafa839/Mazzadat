////
////  Filezsss.swift
////  Naseem
////
////  Created by Eleyan Saad on 7/24/19.
////  Copyright © 2019 Dev Anas. All rights reserved.
////
//
//
//
//import UIKit
//import SwiftyJSON
//import Alamofire
//
//
//class ISCategoryOperations: NSObject {
//    @discardableResult
//    static func GetCategories(countryId:Int?,
//                              categoryId:Int?,
//                              completionHandler: ((_ response:Array<Dictionary<String, AnyObject>>?, _ error: NSError?) -> Void)? = nil) -> URLSessionDataTask {
//
//        // URL
//        let url = ISConstant.apiPath + "GetCategories"
//        let paramertes = [
//            "countryId":ISConstants.country as AnyObject,
//            "key":ISConstants.key,
//            "categoryId": categoryId,
//            "userId":ISConstants.userId ?? "0",
//            ] as Parameters
//
//        let request = AFHTTPRequestSerializer().request(withMethod:"POST", urlString: url, parameters: paramertes, error: nil)
//
//        //        request.addValue(ISSettings.shared.token!.tokenType + " " + ISSettings.shared.token!.accessToken, forHTTPHeaderField: "Authorization")
//        //
//        let dataTask = ISHTTPSessionManager.shared.dataTask(with: request as URLRequest) { (response, responseObject, error) in
//
//            // Error
//            if error != nil {
//                // Print Response Body
//                // print("Error: \(response)") // Error
//                print(error!.localizedDescription)
//
//                if let responseBody = (error! as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data {
//                    let responseBodyString = String(data: responseBody, encoding: String.Encoding.utf8)
//                    print("Error Response Object: \(String(describing: responseBodyString))")
//                }
//
//                let httpResponse = response as! HTTPURLResponse
//                if httpResponse.statusCode == 401 { // Refresh token
//
//
//                } else {
//                    completionHandler?(nil, error as NSError?)
//                }
//
//            } else {
//                print("Success: \(response)")
//                print("Response Object: \(String(describing: responseObject))")
//                // print("Parameters: \(parameters)")
//
//                if let dictionary = responseObject as? Array<Dictionary<String, AnyObject>> {
//                    completionHandler?(dictionary, error as NSError?)
//                } else {
//                    completionHandler?(nil, error as NSError?)
//                }
//            }
//        }
//
//        dataTask.resume()
//
//        return dataTask
//
//    }
//
//}
//
//
//
//
//
//func toJSonString(data : Any) -> String {
//
//    var jsonString = "";
//
//    do {
//
//        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//        jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//
//    } catch {
//        print(error.localizedDescription)
//    }
//
//    return jsonString;
//}
//
//
//
//func arrayToJson(from object:Any) -> String? {
//    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//        return nil
//    }
//    return String(data: data, encoding: String.Encoding.utf8)
//}
//
//
//func convertIntoJSONString(arrayObject: [Any]) -> String? {
//
//    do {
//        let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
//        if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
//            return jsonString as String
//        }
//
//    } catch let error as NSError {
//        print("Array convertIntoJSON - \(error.description)")
//    }
//    return nil
//}
//
//
//func json(from object:Any) -> String? {
//    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//        return nil
//    }
//    return String(data: data, encoding: String.Encoding.utf8)
//}
//
//
//
//
//
