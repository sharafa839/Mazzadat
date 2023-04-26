//
//  AuctionApi.swift
//  Mazadaat
//
//  Created by Sharaf on 07/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya
enum AuctionApi {
    case all
    case showOfficialAuction(auction_id:String)
    case show(auction_id:String)
    case toggleFavorite(auction_id:String)
    case favorites
    case addBid(auction_id:String,price:String)
    case auctionsFilter(search:String? = nil , byCategoryId:String? = nil,code:String? = nil,status:String? = nil,priceFrom:String? = nil,priceTo:String? = nil,endAt:String? = nil,endFrom:String? = nil)
}

extension AuctionApi:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .all,.auctionsFilter:
            return EndPoints.Auction.all.rawValue
        case .showOfficialAuction:
            return EndPoints.Auction.showOfficialAuction.rawValue
        case .show:
            return EndPoints.Auction.show.rawValue
        case .toggleFavorite:
            return EndPoints.Auction.toggleFavorite.rawValue
        case .favorites:
            return EndPoints.Auction.favorite.rawValue
        case .addBid:
            return EndPoints.Auction.addBid.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .all,.auctionsFilter:
            return .get
        case .showOfficialAuction:
            return .get
        case .show:
            return .get
        case .toggleFavorite:
            return .post
        case .favorites:
            return .post
        case .addBid:
            return .post

    }
    }
    
    var task: Task {
        switch self {
        case .all:
            return .requestPlain
        case .showOfficialAuction(let auction_id):
            return .requestParameters(parameters: ["auction_id":auction_id], encoding: URLEncoding.default)
        case .show(let auction_id):
            return .requestParameters(parameters: ["auction_id":auction_id], encoding: URLEncoding.default)
        case .toggleFavorite(let auction_id):
            return .requestParameters(parameters: ["auction_id":auction_id], encoding: JSONEncoding.default)

        case .favorites:
            return .requestPlain
        case .addBid(let auction_id, let price):
            return .requestParameters(parameters: ["auction_id":auction_id,"price":price], encoding: JSONEncoding.default)

        case .auctionsFilter(search: let search, byCategoryId: let byCategoryId, code: let code, status: let status, priceFrom: let priceFrom, priceTo: let priceTo, endAt: let endAt, endFrom: let endFrom):
            var parameter:[String:Any] = [:]
            if let search = search {
                parameter["q"] = search
            }
            if let byCategoryId = byCategoryId {
                parameter["category_id"] = byCategoryId
            }
            if let code = code {
                parameter["code"] = code
            }
            if let status = status {
                parameter["status"] = status

            }
            if let priceFrom = priceFrom {
                parameter["price_from"] = priceFrom
            }
            if let priceTo = priceTo {
                 parameter["price_to"] = priceTo
            }
            if let endAt = endAt {
                parameter["end_at_to"] = endAt
            }
            if let endFrom = endFrom {
                parameter["end_at_from"] = endFrom
            }
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        }
    }
    
    

}
