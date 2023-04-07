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
}

extension AuctionApi:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .all:
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
        case .all:
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

        }
    }
    
    
}
