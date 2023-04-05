//
//  MoyaService.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya

class MoyaServiceHelper<T: TargetType> {
    
        // MARK:- Properties
    
    let provider: MoyaProvider<T>
    
        // MARK:- Init
    
    init(type: NetworkServiceType = .live) {
        let serviceType = type == .live ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        let formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: { data in
            data.prettyPrintedJSONString as String? ?? "## Cannot map data to String ##"
        })
        let loggerConfig = NetworkLoggerPlugin.Configuration(formatter: formatter, logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<T>(stubClosure: serviceType, plugins: [networkLogger])
    }
    
    deinit {
        print("deinit: \(Self.self)")
    }
    
        // MARK: - Methods
    
    func request<R: Codable>(target: T, completion: @escaping(Result<BaseResponse<R>, Error>) -> Void) {
        
        defaultRequest(target: target) { (result: Swift.Result<BaseResponse<R>, Error>) in
            switch result {
                case .success(let response):
                    if response.status == .failure {
                        let error = NetworkError(code: 0, message: response.message ?? L10n.App.somethingWentWrong)
                        completion(.failure(error))
                    } else {
                        completion(.success(response))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func defaultRequest<R: Codable>(target: T, completion: @escaping (Result<R, Error>) -> Void) {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            let error = NetworkError(code: 0, message: L10n.App.noInternetAccess)
            completion(.failure(error))
            return
        }
        
        print("🤩 Network Call: \(T.self), \(target.path)")
        provider.request(target) { result in
            switch result {
                case .success(let value):
                    guard value.statusCode.inRange(closed: 200, 299) else {
                        self.handleFailure(target, response: value, completion: completion)
                        break
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(R.self, from: value.data)
                        completion(.success(response))
                    } catch(let decodeError) {
                        let error = NetworkError(code: 0, message: L10n.App.somethingwentwrongtryagainlater)
                        print("🤯 Decoder Failure in \(T.self) for \(R.self) \nError: \(decodeError)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("🤯 Network Call Failure For \(T.self) \nError: \(error)")
                    self.handleFailure(target, response: error.response, completion: completion)
            }
        }
    }
    
    private func handleFailure<R: Codable>(_ target: T,
                                           response: Response?,
                                           completion: @escaping (Swift.Result<R, Error>) -> Void) {
        if response?.statusCode == 401 {
            Service.shared.saveRequest {
                self.defaultRequest(target: target, completion: completion)
            }
            guard !Service.shared.isRefreshingToken else {return}
            Service.shared.isRefreshingToken = true
            Service.shared.refreshToken { (isSuccess) in
                Service.shared.isRefreshingToken = false
                guard isSuccess else {
                    Service.shared.savedRequests.removeAll()
                    self.LogOut()
                    return
                }
                Service.shared.executeAllSavedRequests()
            }
            return
        } else {
            self.extractError(from: response?.data, completion: completion)
        }
    }
    
    private func debug(request:URLRequest, response:Data?) {
        #if DEBUG
        let jsonResponse = response?.prettyPrintedJSONString ?? ""
        print("================================================================================")
        print("Response \(request)\n\(jsonResponse)")
        print("================================================================================")
        #endif
    }
    
    private func extractError<R: Codable>(from response: Data?,
                                          completion: @escaping (Swift.Result<R, Error>) -> Void) {
        let resultJSON = response?.asDictionary ?? [:]
        
        if let message = resultJSON["message"] as? String, message.isNotEmpty {
            let error = NetworkError(code: 0, message: message)
            completion(.failure(error))
            return
        }
        
        if let responseDict =  resultJSON["response"] as? [String: Any] {
            if let errorsDict = responseDict["errors"] as? [String:Any] {
                var errors = [String]()
                errorsDict.forEach({errors += $0.value as? [String] ?? []})
                let error = NetworkError(code: 0, message: errors.joined(separator: "\n"))
                completion(.failure(error))
                return
            }
        }
        
        let error = NetworkError(code: 0, message: L10n.App.somethingwentwrongtryagainlater)
        completion(.failure(error))
    }
    
    
}

extension Data {
    
    var prettyPrintedJSONString: NSString? { // NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
    
    var asDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: self, options: .allowFragments))
            .flatMap { $0 as? [String: Any] } ?? [:]
    }
}
