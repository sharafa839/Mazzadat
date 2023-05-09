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
    func subscribe(image:MultiPartItem?,subscription_id:String?,paymentMethod:String?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func documents(completion:@escaping(Result<BaseResponse<[UploadDocuments]>,Error>)->Void)
    func uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int,completion:@escaping(Result<BaseResponse<UploadDocuments>,Error>)->Void)
    func auctionHolders(completion:@escaping(Result<BaseResponse<[AuctionHolder]>,Error>)->Void)
    func holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?,completion:@escaping(Result<BaseResponse<[AuctionHolderPlaces]>,Error>)->Void)
    func showHolderPlaces(placeID:String,completion:@escaping(Result<BaseResponse<HolderPlaces>,Error>)->Void)
    func payEntryFee(placeID:String,payment_method_id:String?,image:MultiPartItem?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func getSlider(completion:@escaping(Result<BaseResponse<[SlidersModel]>,Error>)->Void)
    func removeDocuments(type:String,front:Bool?,back:Bool?,completion:@escaping(Result<BaseResponse<[LoginPayload]>,Error>)->Void)
    
    func addAdvertismentRequest(title:String,description:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    
    func addFeedback(message:String,completion:@escaping(Result<BaseResponse<[LoginPayload]>,Error>)->Void)


}

extension HomeNetworkingProtocol {
    private var home : HomeRepo {
      return HomeRepo()
    }
    func faqs(completion:@escaping(Result<BaseResponse<[FAQModel]>,Error>)->Void) {
        home.request(target: .faqs, completion: completion)
    }
    
    func subscribe(image:MultiPartItem?,subscription_id:String?,paymentMethod:String?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void){
        home.request(target: .subscribe(image: image, subscription_id: subscription_id, paymentMethod: paymentMethod), completion: completion)
    }
    
    func documents(completion:@escaping(Result<BaseResponse<[UploadDocuments]>,Error>)->Void){
        home.request(target: .documents, completion: completion)
    }
    func uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int,completion:@escaping(Result<BaseResponse<UploadDocuments>,Error>)->Void){
        home.request(target: .uploadDocuments(frontImage: frontImage, backImage: backImage, id: id), completion: completion)
    }
    func auctionHolders(completion:@escaping(Result<BaseResponse<[AuctionHolder]>,Error>)->Void){
        home.request(target: .auctionHolders, completion: completion)
    }
    func holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?,completion:@escaping(Result<BaseResponse<[AuctionHolderPlaces]>,Error>)->Void){
        home.request(target: .holderPlaces(holderID: holderID, running: running, upcoming: upcoming, expired: expired), completion: completion)
    }
    func showHolderPlaces(placeID:String,completion:@escaping(Result<BaseResponse<HolderPlaces>,Error>)->Void){
        home.request(target: .showHolderPlaces(placeID: placeID), completion: completion)
    }
    func payEntryFee(placeID:String,payment_method_id:String?,image:MultiPartItem?,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        home.request(target: .payEntryFee(image: image, placeID: placeID, payment_method_id: payment_method_id), completion: completion)
    }
    func getSlider(completion:@escaping(Result<BaseResponse<[SlidersModel]>,Error>)->Void) {
        home.request(target: .getSlider, completion: completion)
    }
    
    func removeDocuments(type:String,front:Bool?,back:Bool?,completion:@escaping(Result<BaseResponse<[LoginPayload]>,Error>)->Void) {
        home.request(target: .removeDocument(front: front, back: back, documentTypeId: "\(type)"), completion: completion)
    }
    
    func addAdvertismentRequest(title:String,description:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        home.request(target: .addAdvertisementRequest(title: title, description: description), completion: completion)
    }
    
    func addFeedback(message:String,completion:@escaping(Result<BaseResponse<[LoginPayload]>,Error>)->Void) {
        home.request(target: .addFeedback(message: message), completion: completion)
    }

}


