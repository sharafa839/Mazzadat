//
//  HomeNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 07/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol HomeNetworkingProtocol {
 
    func faqs(completion:@escaping(Result<BaseResponse<[FAQModel]>,Error>)->Void)
    func subscribe(image:MultiPartItem,subscription_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func documents(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int,expiry_date:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func auctionHolders(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func showHolderPlaces(placeID:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func payEntryFee(placeID:String,payment_method_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
}

extension HomeNetworkingProtocol {
    private var home : HomeRepo {
      return HomeRepo()
    }
    func faqs(completion:@escaping(Result<BaseResponse<[FAQModel]>,Error>)->Void) {
        home.request(target: .faqs, completion: completion)
    }
    
    func subscribe(image:MultiPartItem,subscription_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func documents(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int,expiry_date:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func auctionHolders(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func showHolderPlaces(placeID:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
    func payEntryFee(placeID:String,payment_method_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){}
}


