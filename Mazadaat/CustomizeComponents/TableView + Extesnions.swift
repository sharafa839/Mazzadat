



//
//  TableView + Extesnions.swift
//  Dalali_Jamalek(Admin)
//
//  Created by Ghoost on 6/5/19.
//  Copyright © 2019 Mahmoud_abdlAziz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
extension UITableView {
    
    func registerNib<Cell:UITableViewCell>(cell:Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<Cell:UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell =  self.dequeueReusableCell(withIdentifier: identifier) as? Cell else { fatalError(" Error in cell") }
        return cell
    }
    
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
     func setEmptyView(title: String, message: String, messageImage: UIImage) {
           
           let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
           
           let messageImageView = UIImageView()
           let titleLabel = UILabel()
           let messageLabel = UILabel()
           
           messageImageView.backgroundColor = .clear
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           messageImageView.translatesAutoresizingMaskIntoConstraints = false
           messageLabel.translatesAutoresizingMaskIntoConstraints = false
           
           titleLabel.textColor = UIColor.black
           titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
           
           messageLabel.textColor = UIColor.lightGray
           messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
           
           emptyView.addSubview(titleLabel)
           emptyView.addSubview(messageImageView)
           emptyView.addSubview(messageLabel)
           
           messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
           messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
           messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
           
           titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
           titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           
           messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
           messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           
           messageImageView.image = messageImage
           titleLabel.text = title
           messageLabel.text = message
           messageLabel.numberOfLines = 0
           messageLabel.textAlignment = .center
           
           UIView.animate(withDuration: 1, animations: {
               
               messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
           }, completion: { (finish) in
               UIView.animate(withDuration: 1, animations: {
                   messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
               }, completion: { (finishh) in
                   UIView.animate(withDuration: 1, animations: {
                       messageImageView.transform = CGAffineTransform.identity
                   })
               })
               
           })
           
           self.backgroundView = emptyView
           self.separatorStyle = .none
       }
       
       func restore() {
           
           self.backgroundView = nil
           self.separatorStyle = .none
           
       }
    
    
}
extension UITableViewCell {
    
    func setAnimationFromSide() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0.5
        UIView.animate(withDuration: 1.0) {
            self.layer.transform = CATransform3DIdentity
            self.alpha = 1.0
        }
    }
    
    func setAnimationFadeIn() {
           let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 10, 0)
           self.layer.transform = rotationTransform
           self.alpha = 0.5
        UIView.animate(withDuration: 0.75) {
               self.layer.transform = CATransform3DIdentity
               self.alpha = 1.0
           }
       }
       
    
    
}
class APIs: NSObject {

    class func isConnectedToInternet() -> Bool {
           return NetworkReachabilityManager()!.isReachable
       }
    
//    class func genericApiWithPagination<T:Decodable>( pageNo:Int,url:String,method:HTTPMethod,paameters:Parameters?,encoding:ParameterEncoding,headers:HTTPHeaders?,completion:@escaping (T?,Error?,Int?) -> ()) {
//        AF.request(url, method: method,parameters:paameters,encoding:encoding, headers: headers, interceptor: CustomInterceptor()).validate(statusCode: 200..<502).responseJSON { (response) in
//            print (response)
//print(paameters)
//            print(response.request)
//         switch response.response?.statusCode {
//            case (200..<500)?:
//
//                switch response.result{
//                case .success(_):
//                  guard let data=response.data else {return}
//                        print("response data to json",JSON(data))
//                    do{
//                        let data = try JSONDecoder().decode(T.self, from: data)
//                        completion(data, nil, 200)
//                    }catch{
//                        print("errrror",error.localizedDescription)
//                        ActivityIndicatorManager.shared.hideProgressView()
//                        completion(nil, nil, 200)
//                    }
//                case .failure(let error):
//                    ActivityIndicatorManager.shared.hideProgressView()
//                    print(error.localizedDescription)
//                    completion(nil, error, 200)
//                }
//            default: completion(nil, nil, response.response?.statusCode)
//        }}}
    
    
//    class func sendOrders<T:Decodable>(url:String , method: HTTPMethod , headers:HTTPHeaders,params : Parameters , completion: @escaping(T?,Error?,Int?)->Void){
//
//               let url = URL(string: url)
//               var request = URLRequest(url: url!)
//               request.method = method
//              // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//               request.headers = headers
//               if (!JSONSerialization.isValidJSONObject(params)) {
//                   print("is not a valid json object")
//                   return
//               }
//        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
//        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
//            print(response.response?.statusCode)
//
//            switch response.response?.statusCode {
////            case 405?:
////                if let da = response.data {
////                    print(JSON(da))
////                }
////            case 422? :
////                if let dat = response.data {
////                    print(JSON(dat))
////                }
////
//            case (200..<202)?:
//                switch response.result{
//                case .success(_):
//                    guard let data=response.data else {return}
//                    print(JSON(data))
//                    do{
//                        let data = try JSONDecoder().decode(T.self, from: data)
//                        completion(data, nil, 200)
//                    }catch{
//              //          print("errrror",error.localizedDescription)
//                        ActivityIndicatorManager.shared.hideProgressView()
//                        completion(nil, nil, 200)
//                    }
//                case .failure(let error):
//                    ActivityIndicatorManager.shared.hideProgressView()
//                    print(error.localizedDescription)
//                    completion(nil, error, 200)
//                }
//
//            default: completion(nil, nil, response.response?.statusCode)
//            }}}
//
    
//
//    class func registerProvider(id:String,
//                           image:UIImage,
//                           params:Parameters,
//                           completion: @escaping(_ error:Error?, _ data: AddCenterModel?, _ code:Int?)->()) {
//              let urlString = "https://Dalil-taelim.com/api/centers/\(id)"
//              let headers: HTTPHeaders = [
//                "Authorization": HelperK.getUserToken(),
//                  "Accept": "application/json"
//              ]
//        ActivityIndicatorManager.shared.showProgressView()
//        print(params)
//    AF.upload( multipartFormData: { multipartFormData in
//        for (key, value) in params{
//                   if value is String || value is Int{
//                       multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//            }}
//            if image.size.width != 0 {
//                multipartFormData.append(image.jpegData(compressionQuality: 0.6)!, withName: "images[]", fileName: "image.jpeg", mimeType: "image/jpeg")
//            }},
//               to: urlString,
//               method: .post,
//               headers: headers).validate(statusCode: 200..<500).responseJSON { (resp) in
//           //    print(resp.response?.statusCode)
//        print(resp.request)
//        print(resp.response)
//        ActivityIndicatorManager.shared.hideProgressView()
//
//                switch resp.response?.statusCode {
//                case (200...201)?:
//                    switch resp.result {
//                    case .failure(let error):
//                        completion(error,nil,200)
//                          case .success(_):
//                            guard let dat = resp.data else { return }
//                              do {
//                                  let res = try JSONDecoder().decode(AddCenterModel.self, from: dat)
//                                completion(nil,res, 200)
//                              } catch {
//        // print("register Provider errrooorrr", error.localizedDescription)
//                                completion(nil,nil, 200)
//                       }}
//                    default: HelperK.showError(title: "somethingWentWrong", subtitle: "")
//                  }}}
    
}
