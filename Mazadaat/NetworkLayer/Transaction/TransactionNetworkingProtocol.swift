//
//  TransactionNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol TransactionNetworkingProtocol {
func all(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
func myBalance(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
func generateCheckout(value:String,paymentToken:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
func checkPayment(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
func requestRefund(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
}

extension TransactionNetworkingProtocol {
    private var transaction:TransactionRepo {
        return TransactionRepo()
    }
    
    func all(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        transaction.request(target: .all, completion: completion)
    }
    
    func myBalance(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        transaction.request(target: .myBalance, completion: completion)

    }
    
    func generateCheckout(value:String,paymentToken:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        transaction.request(target: .generateCheckout(value: value, paymentToken: paymentToken), completion: completion)

    }
    
    func checkPayment(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        transaction.request(target: .checkPayment, completion: completion)
    }
    
    func requestRefund(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        transaction.request(target: .requestRefund, completion: completion)

    }
    
    
    
}
