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
    case uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int)
    case auctionHolders
    case holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?)
    case showHolderPlaces(placeID:String)
    case payEntryFee(image:MultiPartItem?,placeID:String?,payment_method_id:String?)
    case getSlider
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
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .faqs:
            return .get
        case .subscribe:
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
            var multipart: [MultipartFormData] = []
            let paramters = [ "document_type_id" : "\(id)"]
            let multipartParameters = paramters.map { (key, value) in
                MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
            }
           
            let multiPartItemFrontFormData = MultipartFormData(provider: .data(frontImage.data), name: frontImage.keyName, fileName: frontImage.fileName, mimeType: frontImage.mimeType)
            let multiPartItemBackFormData = MultipartFormData(provider: .data(backImage.data), name: backImage.keyName, fileName: backImage.fileName, mimeType: backImage.mimeType)

            multipart.append(multiPartItemFrontFormData)
            multipart.append(multiPartItemBackFormData)
            multipart.append(contentsOf: multipartParameters)
            return .uploadMultipart(multipart)
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
            
        }
    }
    
    
}
