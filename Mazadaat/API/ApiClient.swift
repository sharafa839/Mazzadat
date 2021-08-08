

 import UIKit


 import Alamofire
 class ApiClient: NSObject {
    
    class func sendRequestJson(path : String , parameters : Dictionary<String , Any> , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void  , httpMethod: HTTPMethod ,  shouldShowProgress : Bool = false, progressMsg : String? , isRequireToken :  Bool = false){
        //url of the request
        let requestPath =  SessionManager.sharedManger.apiPath + path
        //show dialog progress
        if(shouldShowProgress){
             ActivityIndicatorManager.start(progressMsg!);
        }


       //Content-Type "application/x-www-form-urlencoded"
       //Authorization "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjU2LCJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXJfbG9naW4iLCJpYXQiOjE1NTI5NDYzOTcsImV4cCI6MTU1NDE1NTk5NywibmJmIjoxNTUyOTQ2Mzk3LCJqdGkiOiJUYVRlNVFDbFFxeENMSHl3In0.bzUEsePf43djXl2M3JucN7U0bKc_xoRO88_Cl36fq1g"

        var headers : [String : String] = [:]


        let token = AppData.userToken

        let lang = UserDefaults.standard.string(forKey: "lang")

        if isRequireToken {
            
            
            headers = ["Authorization": "Bearer \(token ?? "")",
                "Accept":"application/json",
                "X-localization":"ar",
                "Content-Type":"multipart/form-data"
            ]

        }


        //fire the request


        Alamofire.request(requestPath, method: httpMethod ,  parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON { (response) in

            print("request fired")
            debugPrint("request: \(response.request)")
            debugPrint("params: \(parameters)")
            debugPrint("headeer: \(headers)")
            debugPrint("Response Recieved : \(Date())")
             debugPrint("response: \(String(describing: response.result.value))")
            print("\(response.result.error)")
            
       
            
            
            
            if(shouldShowProgress){
                ActivityIndicatorManager.stop();
            }
            //handle the response



            handleRequestResponse(response: response, isEdit: false, success: success, failure: failure )
        }

    }

    class func sendRequest(path : String , parameters : Dictionary<String , Any> , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void  , httpMethod: HTTPMethod ,  shouldShowProgress : Bool = false, progressMsg : String? , isRequireToken :  Bool = false){
        //url of the request
        let requestPath =  SessionManager.sharedManger.apiPath + path
        //show dialog progress
        if(shouldShowProgress){
             ActivityIndicatorManager.start(progressMsg!);
        }


       //Content-Type "application/x-www-form-urlencoded"
       //Authorization "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjU2LCJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXJfbG9naW4iLCJpYXQiOjE1NTI5NDYzOTcsImV4cCI6MTU1NDE1NTk5NywibmJmIjoxNTUyOTQ2Mzk3LCJqdGkiOiJUYVRlNVFDbFFxeENMSHl3In0.bzUEsePf43djXl2M3JucN7U0bKc_xoRO88_Cl36fq1g"

        var headers : [String : String] = [:]


        let token = AppData.userToken
print("TOKEN",token)
        let lang = UserDefaults.standard.string(forKey: "lang")

        if isRequireToken {
            
            
            headers = ["Authorization": "Bearer \(token ?? "")",
                "Accept":"application/json",
                "X-localization":AppData.lang,
                "Content-Type":"multipart/form-data"
            ]

        }


        //fire the request


        Alamofire.request(requestPath, method: httpMethod ,  parameters: parameters, encoding: URLEncoding.default, headers:headers).responseJSON { (response) in

            print("request fired")
            debugPrint("request: \(response.request)")
            debugPrint("params: \(parameters)")
            debugPrint("headeer: \(headers)")
            debugPrint("Response Recieved : \(Date())")
             debugPrint("response: \(String(describing: response.result.value))")
            print("\(response.result.error)")
            
       
            
            
            
            if(shouldShowProgress){
                ActivityIndicatorManager.stop();
            }
            //handle the response



            handleRequestResponse(response: response, isEdit: false, success: success, failure: failure )
        }

    }

            class func sendRequestWithImage(path : String  , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void ,httpMethod: HTTPMethod , shouldShowProgress : Bool = false, progressMsg : String? , Image : UIImage? , imageKeyName : String , fileName : String, params  : Dictionary<String ,  Any> = [:] , isRequireHeader  : Bool = true){
            let requestPath = path
            if(shouldShowProgress){
                 ActivityIndicatorManager.start(progressMsg!);
            }
    
    
            var headers : [String : String] = [:]
    
                let token =       UserDefaults.standard.string(forKey: "token")

            if(isRequireHeader){
             headers["Authorization"] = "Bearer \(token ?? "")"
            }
            Alamofire.upload(multipartFormData: { (multipartFormData) in
    
                let imageData = Image!.jpegData(compressionQuality: 0.50)

                if imageData != nil {
              
                    multipartFormData.append(imageData!, withName: imageKeyName, fileName: "swift_file.png", mimeType: "image/png")

                    
                }else{
                    multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                }
                for (key , value) in params {
    
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key )
                }
            }, usingThreshold:UInt64.init(), to: path, method: .post, headers: headers, encodingCompletion: { (result) in
                if(shouldShowProgress){
                    ActivityIndicatorManager.start()
    
                }
    
                switch result {
                case .success(let upload, _, _):
    
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        print(progress)
                        //                    ActivityIndicatorManager.showProgress(progress: 50)
                    })
    
                    upload.responseJSON { response in
                        print(response.result.value)

                        //print response.result
                        ActivityIndicatorManager.stop();
                        handleRequestResponse(response: response, isEdit: false, success: success, failure: failure)
    
                    }
    
                case .failure(let encodingError):
                    //print encodingError.description
                    print("err is \(encodingError )")
                    break
                }
            })
        }

    
    
    class func uploadDocumentImages(path : String  , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void ,httpMethod: HTTPMethod , shouldShowProgress : Bool = false, progressMsg : String? , backImg : UIImage? ,forntImg : UIImage? , imageKeyName : String , fileName : String, params  : Dictionary<String ,  Any> = [:] , isRequireHeader  : Bool = true){
            let requestPath = path
            if(shouldShowProgress){
                 ActivityIndicatorManager.start(progressMsg!);
            }
    
    
            var headers : [String : String] = [:]
    
       
        let token = AppData.userToken

           let lang = UserDefaults.standard.string(forKey: "lang")

           if(isRequireHeader) {
               
               
               headers = ["Authorization": "Bearer \(token ?? "")",
                   "Accept":"application/json",
                   "X-localization":AppData.lang,
                   "Content-Type":"multipart/form-data"
               ]

           }
            Alamofire.upload(multipartFormData: { (multipartFormData) in
    
                let imageDataFront = backImg!.jpegData(compressionQuality: 0.50)
                let imageDataBack = forntImg!.jpegData(compressionQuality: 0.50)

                let frontimageName = "img-\(CACurrentMediaTime()).png"
                let backImgName = "img-\(CACurrentMediaTime()).png"

                if imageDataFront != nil && imageDataBack != nil {
              
                    multipartFormData.append(imageDataFront!, withName: "front_face", fileName: frontimageName, mimeType: "image/png")

                      multipartFormData.append(imageDataBack!, withName: "back_face", fileName: backImgName, mimeType: "image/png")
                }else{
                    multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                }
                for (key , value) in params {
    
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key )
                }
            }, usingThreshold:UInt64.init(), to: path, method: .post, headers: headers, encodingCompletion: { (result) in
                if(shouldShowProgress){
                    ActivityIndicatorManager.start()
    
                }
    
                switch result {
                case .success(let upload, _, _):
    
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        print(progress)
                        //                    ActivityIndicatorManager.showProgress(progress: 50)
                    })
    
                    upload.responseJSON { response in
                        print(response.result.value)

                        //print response.result
                        ActivityIndicatorManager.stop();
                        handleRequestResponse(response: response, isEdit: false, success: success, failure: failure)
    
                    }
    
                case .failure(let encodingError):
                    //print encodingError.description
                    print("err is \(encodingError )")
                    break
                }
            })
        }

    
            class func sendRequestWithMutliImage(path : String  , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void ,httpMethod: HTTPMethod , shouldShowProgress : Bool = false, progressMsg : String? , imgID : UIImage? , imgPassport : UIImage?, imgCertify : UIImage?, imgMedical : UIImage?, imgIDKeyName : String, imgPassportKeyName : String, imgCertifyKeyName : String, imgMedcalKeyName : String , fileName : String, params  : Dictionary<String ,  Any> = [:] , isRequireHeader  : Bool = true){
            let requestPath = path
            if(shouldShowProgress){
                 ActivityIndicatorManager.start(progressMsg!);
            }
    
    
            var headers : [String : String] = [:]
    
                let token =       UserDefaults.standard.string(forKey: "token")

            if(isRequireHeader){
             headers["Authorization"] = "Bearer \(token ?? "")"
            }
            Alamofire.upload(multipartFormData: { (multipartFormData) in
    
                let imagID = imgID!.jpegData(compressionQuality: 0.50)
                let imgPassport = imgPassport!.jpegData(compressionQuality: 0.50)
                let imgCertify = imgCertify!.jpegData(compressionQuality: 0.50)
                let imgMedcal = imgMedical!.jpegData(compressionQuality: 0.50)

                if imagID != nil {
              
                    multipartFormData.append(imagID!, withName: imgIDKeyName, fileName: "swift_file1.png", mimeType: "image/png")

                    
                }else{
                    multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                }
                
                if imgPassport != nil {
                          
                                multipartFormData.append(imgPassport!, withName: imgPassportKeyName, fileName: "swift_file2.png", mimeType: "image/png")

                                
                            }else{
                                multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                            }
                            
                
                
                if imgCertify != nil {
                          
                                multipartFormData.append(imgCertify!, withName: imgCertifyKeyName, fileName: "swift_file3.png", mimeType: "image/png")

                                
                            }else{
                                multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                            }
                            
                
                
                if imgMedcal != nil {
                          
                             multipartFormData.append(imgMedcal!, withName: imgMedcalKeyName, fileName: "swift_file4.png", mimeType: "image/png")

                                
                            }else{
                                multipartFormData.append("".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "ss")
                            }
                            
                
                
                for (key , value) in params {
    
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key )
                }
            }, usingThreshold:UInt64.init(), to: path, method: .post, headers: headers, encodingCompletion: { (result) in
                if(shouldShowProgress){
                    ActivityIndicatorManager.start()
    
                }
    
                switch result {
                case .success(let upload, _, _):
    
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        print(progress)
                        //                    ActivityIndicatorManager.showProgress(progress: 50)
                    })
    
                    upload.responseJSON { response in
                        print(response.result.value)

                        //print response.result
                        ActivityIndicatorManager.stop();
                        handleRequestResponse(response: response, isEdit: false, success: success, failure: failure)
    
                    }
    
                case .failure(let encodingError):
                    //print encodingError.description
                    print("err is \(encodingError )")
                    break
                }
            })
        }




    class func handleRequestResponse(response : DataResponse<Any> ,isEdit : Bool ,success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void ){
        switch response.result {

        case .success :
            if let result = response.result.value  {
                let statusCode = (response.response?.statusCode)!
                if statusCode != 200 &&  statusCode != 201{
                    let dict =  result as! Dictionary<String, Any>
                    let errorVal = dict["message"] as? String ?? ""
                    let errorDescription = dict["message"] as? String ?? ""
                    let error = LError(error: errorVal, errorDescription: errorDescription)
                    failure(error)
                    return
                }else{
                    let dict =  result as! Dictionary<String, Any>
                
                    var errorVal = ""
                    
                    
                    if let value = dict["status"] as? Dictionary<String, AnyObject>{
                        
                        if let msg = value["message"] as? [String]{
                            errorVal = msg.first ?? ""
                        }
                    }
                    
                    
                    
                    
                    
                    
                    if errorVal == "You have to be logged in first ." {
                        
                        AppData.isLogin = false
                                            
                                  let story = UIStoryboard(name: "Auth", bundle:nil)
                                             let vc = story.instantiateViewController(withIdentifier: "authTab")
                                             UIApplication.shared.windows.first?.rootViewController = vc
                                             UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }else{
                        success(result)

                    }
                    
                    
                }

            }
            break;

        case .failure(let error) :

            if isEdit == true {
                success("String")

            }




            if let err = error as? URLError, err.code == .notConnectedToInternet {
                // no internet connection
                let message = "no Internet connection"
            
                let error = LError(error: "", errorDescription: message)
                failure(error)

            }


            else if let err = error as? URLError, (err.code.rawValue == 401) {
                // no internet connection
                SessionManager.sharedManger.token = nil
                SessionManager.saveSessionManger()
                let message = "not authnticated"
                let error = LError(error: "", errorDescription: message)
                DataClient.shared.delegate.onInvalidLogin()
                failure(error)
            }



            else if let result = response.result.value {
                let json = result as! [String: Any]
                let errorVal = json["message"] as? String ?? ""
                let errorDescription = json["message"] as? String ?? ""
                let error = LError(error: errorVal, errorDescription: errorDescription)
                failure(error)
            }
            //            }else {
            //                SessionManager.sharedManger.token = nil
            //                SessionManager.saveSessionManger()
            //                let message = "not authnticated"
            //                let error = LError(error: "", errorDescription: message)
            //                DataClient.shared.delegate.onInvalidLogin()
            //                failure(error)
            //            }
            //
            break;
        }

    }
    
    
     
            class func sendRequestWithJsonContacts(path : String , parameters : Dictionary<String , Any> , success : @escaping ( _ respone : Any) -> Void, failure : @escaping ( _ error : LError) -> Void  , httpMethod: HTTPMethod ,  shouldShowProgress : Bool = false, progressMsg : String? , isRequireToken :  Bool = false){
                 //url of the request
                 let requestPath =  SessionManager.sharedManger.apiPath + path
                 //show dialog progress
                 if(shouldShowProgress){
                      ActivityIndicatorManager.start(progressMsg!);
                 }


                //Content-Type "application/x-www-form-urlencoded"
                //Authorization "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjU2LCJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXJfbG9naW4iLCJpYXQiOjE1NTI5NDYzOTcsImV4cCI6MTU1NDE1NTk5NywibmJmIjoxNTUyOTQ2Mzk3LCJqdGkiOiJUYVRlNVFDbFFxeENMSHl3In0.bzUEsePf43djXl2M3JucN7U0bKc_xoRO88_Cl36fq1g"

                 var headers : [String : String] = [:]


             
                let token = AppData.userToken
                let lang = UserDefaults.standard.string(forKey: "lang")


                if isRequireToken {
                    
                    
                    headers = ["Authorization": "Bearer \(token )",
                        "Accept":"application/json",
                        "X-localization":AppData.lang,
                        "Content-Type":"application/json"                    ]

                }
                Alamofire.request(requestPath, method: httpMethod ,  parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON { (response) in

                     print("request fired")
                     debugPrint("request: \(response.request)")
    //                 debugPrint("params: \(parameters)")
                     debugPrint("headeer: \(headers)")
                     debugPrint("Response Recieved : \(Date())")
                      debugPrint("response: \(String(describing: response.result.value))")
                     print("\(response.result.error)")





                     if(shouldShowProgress){
                         ActivityIndicatorManager.stop();
                     }
                     //handle the response
        print("ok")


                     handleRequestResponse(response: response, isEdit: false, success: success, failure: failure )
                 }

             }




 }
