//
//  MoyaService.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class MoyaHelper<T: TargetType> {
    
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
                    if response.status == .fail {
                        let error = NetworkError(code: 0, message: response.message?.first ?? "L10n.App.somethingWentWrong")
                        if let message = response.message?.first  {
                            if message == "You have to be logged in first ."{
                                HelperK.deletUserDefaults()
                                AppUtilities.changeRoot(root: UINavigationController(rootViewController: LoginViewController(viewModel: LoginViewModel())))
                                let error = NetworkError(code: 9, message: response.message?.first ?? "L10n.App.somethingWentWrong")
                                completion(.failure(error))
                            }else {
                                completion(.failure(error))
                            }
                        }
                       
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
            let error = NetworkError(code: 0, message: "NoInterNet")
            completion(.failure(error))
            return
        }
        
        print("🤩 Network Call: \(T.self), \(target.path)")
        provider.request(target) { result in
            switch result {
                case .success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(R.self, from: value.data)
                        completion(.success(response))
                    } catch(let decodeError) {
                        let error = NetworkError(code: 0, message: "L10n.App.somethingwentwrongtryagainlater")
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
        
        if let message = resultJSON["message"] as? [String], !message.isEmpty {
            let error = NetworkError(code: 0, message: message.first!)
            completion(.failure(error))
            return
    }
    
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

    public struct NetworkError: Error, LocalizedError, Codable {
        
        var code: Int = 0
        var message: String = ""
        
        public var localizedDescription: String {
            message
        }
        
        public var errorDescription: String? {
            message
        }
    }

