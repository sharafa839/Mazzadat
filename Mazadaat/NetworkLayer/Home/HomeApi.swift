//
//  HomeApi.swift
//  Mazadaat
//
//  Created by Sharaf on 07/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya
import UIKit

enum HomeApiServices {
    case faqs
    case subscribe(image:MultiPartItem?,subscription_id:String?,paymentMethod:String?)
    case documents
    case uploadDocuments(frontImage : String ,backImage: String,id:Int)
    case auctionHolders
    case holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?)
    case showHolderPlaces(placeID:String)
    case payEntryFee(image:MultiPartItem?,placeID:String?,payment_method_id:String?)
    case getSlider
    case removeDocument(front:Bool?,back:Bool?,documentTypeId:String)
    case addAdvertisementRequest(title:String,description:String)
    case addFeedback(message:String)
    case sendMessage(message:String,auctionId:String?)
}

extension HomeApiServices:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .faqs:
            return EndPoints.Home.faqs.rawValue
        case .subscribe:
            return EndPoints.Home.subscribe.rawValue
        case .documents:
            return EndPoints.Home.documents.rawValue
        case .uploadDocuments:
            return EndPoints.Home.uploadDocuments.rawValue
        case .auctionHolders:
            return EndPoints.Home.auctionHolder.rawValue
        case .holderPlaces:
            return EndPoints.Home.holderPlaces.rawValue
        case .showHolderPlaces:
            return EndPoints.Home.showHolderPlaces.rawValue
        case .payEntryFee:
            return EndPoints.Home.payEntreeFee.rawValue
        case .getSlider:
            return EndPoints.Home.slider.rawValue
        case .removeDocument:
            return EndPoints.Home.removeDocument.rawValue
        case .addAdvertisementRequest:
            return EndPoints.Home.addAdvertisementRequest.rawValue
        case .addFeedback:
            return EndPoints.Home.addFeedback.rawValue
        case .sendMessage:
            return EndPoints.Home.sendMessage.rawValue
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .faqs:
            return .get
        case .subscribe,.sendMessage:
            return .post
        case .documents:
            return .get
        case .uploadDocuments:
            return .post
        case .auctionHolders:
            return .get
        case .holderPlaces:
            return .get
        case .showHolderPlaces:
            return .get
        case .payEntryFee:
            return .post
        case .getSlider:
            return .get
        default:return .post
        }
    }
    
    var task: Task {
        switch self {
        case .faqs,.getSlider:
            return .requestPlain
        case .subscribe(let image ,let subscription_id,let paymentMethod):
            var multipart: [MultipartFormData] = []
            let imageName = "img-\(CACurrentMediaTime()).png"
            var parameters: [String: String] = [:]
            if let subscription_id = subscription_id {
                parameters["subscription_id"] = subscription_id
            }
            if let paymentMethod = paymentMethod {
                parameters["payment_method"] = paymentMethod
            }
            let multipartParameters = parameters.map { (key, value) in
                MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
            }
            multipart.append(contentsOf: multipartParameters)
            if let image = image {
                let multiPartItem = MultiPartItem(data: image.data , fileName: imageName, mimeType: "image/png", keyName: "img")
                let multiPartImage  = MultipartFormData(provider: .data(multiPartItem.data), name: multiPartItem.keyName, fileName: multiPartItem.fileName, mimeType: multiPartItem.fileName)
                multipart.append(multiPartImage)
            }
            
          
           
           
            
            return .uploadMultipart(multipart)
            
        case .documents:
            return .requestPlain
        case .uploadDocuments(let frontImage, let backImage, let id):
            let paramters = [ "document_type_id" : "\(id)","front_face":frontImage,"back_face":backImage]
            return.requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        case .auctionHolders:
            return .requestPlain
        case .holderPlaces(let holderID, let running, let upcoming,let  expired):
            var parameter:[String:Any] = [:]
            if let running = running {
                parameter["running"] = running
            }
            if let upcoming = upcoming {
                parameter["upcoming"] = upcoming
            }
            if let expired = expired {
                parameter["expired"] = expired
            }
            parameter["holder_id"] = holderID
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case .showHolderPlaces(let placeId):
            return .requestParameters(parameters: ["place_id":placeId], encoding: URLEncoding.default)
        case .payEntryFee(let image,let placeID, let payment_method_id):
            var multipart: [MultipartFormData] = []
            let imageName = "img-\(CACurrentMediaTime()).png"
            var parameters: [String: String] = [:]
            if let placeID = placeID {
                parameters["place_id"] = placeID
            }
            
            if let payment_method_id = payment_method_id {
                parameters["payment_method_id"] = payment_method_id
            }
            
            guard let image = image else {
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            }

           
            let multipartParameters = parameters.map { (key, value) in
                MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
            }
            multipart.append(contentsOf: multipartParameters)
          
            let multiPartItem = MultiPartItem(data: image.data , fileName: image.fileName, mimeType: "image/png", keyName:image.keyName )
                let multiPartImage  = MultipartFormData(provider: .data(multiPartItem.data), name: multiPartItem.keyName, fileName: multiPartItem.fileName, mimeType: multiPartItem.fileName)
                multipart.append(multiPartImage)
            
            print(multipart)
            
            return .uploadMultipart(multipart)
            
        case .removeDocument( let front,  let back, let documentTypeId):
            var parameter:[String:Any] = [:]
            if let front = front {
                parameter["front_face"] = front
            }
            if let back = back {
                parameter["back_face"] = back
            }
            parameter["document_type_id"] = documentTypeId
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case .addAdvertisementRequest( let title,let description):
            return .requestParameters(parameters: ["title":title,"description":description], encoding: JSONEncoding.default)
        case .addFeedback( let message):
            return .requestParameters(parameters: ["message":message], encoding: JSONEncoding.default)

        case .sendMessage(message: let message, auctionId: let auctionId):
            var parameter:[String:Any] = [:]
            if let auctionId = auctionId {
                parameter["auction_id"] = auctionId
            }
            parameter["message"] = message
            
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)

        }
    }
    
    
}
