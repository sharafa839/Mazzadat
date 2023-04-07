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
    case subscribe(image:MultiPartItem,subscription_id:String)
    case documents
    case uploadDocuments(frontImage : MultiPartItem ,backImage: MultiPartItem,id:Int,expiry_date:String)
    case auctionHolders
    case holderPlaces(holderID:String,running:Bool?,upcoming:Bool?,expired:Bool?)
    case showHolderPlaces(placeID:String)
    case payEntryFee(placeID:String,payment_method_id:String)
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
        }
    }
    
    var task: Task {
        switch self {
        case .faqs:
            return .requestPlain
        case .subscribe(let image ,let subscription_id):
            var multipart: [MultipartFormData] = []
            let imageName = "img-\(CACurrentMediaTime()).png"
            let parameters: [String: String] = ["subscription_id":subscription_id]
            let multiPartItem = MultiPartItem(data: image.data , fileName: imageName, mimeType: "image/png", keyName: "img")
            let multiPartImage  = MultipartFormData(provider: .data(multiPartItem.data), name: multiPartItem.keyName, fileName: multiPartItem.fileName, mimeType: multiPartItem.fileName)
            
            let multipartParameters = parameters.map { (key, value) in
                MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
            }
            multipart.append(multiPartImage)
            multipart.append(contentsOf: multipartParameters)
            return .uploadMultipart(multipart)
            
        case .documents:
            return .requestPlain
        case .uploadDocuments(let frontImage, let backImage, let id, let expiry_date):
            var multipart: [MultipartFormData] = []
            let paramters = [ "document_type_id" : "\(id)", "expiry_date":expiry_date ]
            let multipartParameters = paramters.map { (key, value) in
                MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
            }
            let frontimageName = "img-\(CACurrentMediaTime()).png"
            let backImgName = "img-\(CACurrentMediaTime()).png"
            let multiPartItemFront = MultiPartItem(data: frontImage.data, fileName: frontimageName, mimeType: "image/png", keyName: "front_face")
            let multiPartItemFrontFormData = MultipartFormData(provider: .data(multiPartItemFront.data), name: multiPartItemFront.keyName, fileName: multiPartItemFront.fileName, mimeType: multiPartItemFront.mimeType)
            let multiPartItemBack = MultiPartItem(data: backImage.data, fileName: backImgName, mimeType: "image/png", keyName: "back_face")
            let multiPartItemBackFormData = MultipartFormData(provider: .data(multiPartItemBack.data), name: multiPartItemBack.keyName, fileName: multiPartItemBack.fileName, mimeType: multiPartItemBack.mimeType)

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
        case .payEntryFee(let placeID, let payment_method_id):
            return .requestParameters(parameters: ["place_id":placeID,"payment_method_id":payment_method_id], encoding: JSONEncoding.default)
        }
    }
    
    
}
