//
//  AuctionNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 07/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol AuctionNetworkingProtocol {
    
    func all(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func showOfficialAuction(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func show(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func toggleFavorite(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func favorites( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    func addBid(auction_id:String,price:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    
}

extension AuctionNetworkingProtocol {
    private var auction:AuctionRepo {
        return AuctionRepo()
    }
    
    func all(completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .all, completion: completion)
    }
    
    func showOfficialAuction(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .showOfficialAuction(auction_id: auction_id), completion: completion)
    }
    
    func show(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .show(auction_id: auction_id), completion: completion)
    }
    
    func toggleFavorite(auction_id:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .toggleFavorite(auction_id: auction_id), completion: completion)
    }
    
    func favorites( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .favorites, completion: completion)
    }
    
    func addBid(auction_id:String,price:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        auction.request(target: .addBid(auction_id: auction_id, price: price), completion: completion)
    }
}
