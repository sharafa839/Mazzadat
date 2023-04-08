//
//  TransactionApi.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import PassKit
import Moya
enum TransactionApi {
    case all
    case myBalance
    case generateCheckout(value:String,paymentToken:String)
    case checkPayment
    case requestRefund
}

extension TransactionApi:BaseApiHeadersProtocol,TargetType {
    var path: String {
        switch self {
        case .all:
            return EndPoints.Transactions.all.rawValue
        case .myBalance:
            return EndPoints.Transactions.myBalance.rawValue
        case .generateCheckout:
            return EndPoints.Transactions.generateCheckout.rawValue
        case .checkPayment:
            return EndPoints.Transactions.checkPayment.rawValue
        case .requestRefund:
            return EndPoints.Transactions.requestRefund.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .generateCheckout,.requestRefund:
            return .post
            
        default : return .get
        
        }
    }
    
    var task: Task {
        switch self {
        
        case .generateCheckout(let value, let paymentToken):
            return .requestParameters(parameters: ["value":value,"payment_token":paymentToken], encoding: JSONEncoding.default)
        default : return .requestPlain
        }
    }
    
    
}
