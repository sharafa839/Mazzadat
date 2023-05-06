//
//  AuctionNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 07/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol AuctionNetworkingProtocol {
    
    func all(myBids:Bool? ,myAuction:Bool?,completion:@escaping(Result<BaseResponse<[FavoriteModel]>,Error>)->Void)
    func showOfficialAuction(auction_id:String,completion:@escaping(Result<BaseResponse<AuctionDetailsModel>,Error>)->Void)
    func show(auction_id:String,completion:@escaping(Result<BaseResponse<AuctionDetailsModel>,Error>)->Void)
    func toggleFavorite(auction_id:String,completion:@escaping(Result<BaseResponse<FavoriteModel>,Error>)->Void)
    func favorites( completion:@escaping(Result<BaseResponse<[FavoriteModel]>,Error>)->Void) 
    func addBid(auction_id:String,price:String, completion:@escaping(Result<BaseResponse<FavoriteModel>,Error>)->Void)
    func filterAuctions(search:String?  , byCategoryId:String? ,code:String? ,status:String? ,priceFrom:String? ,priceTo:String? ,endAt:String?,endFrom:String?, completion:@escaping(Result<BaseResponse<[CategoryAuctions]>,Error>)->Void)
}

extension AuctionNetworkingProtocol {
    private var auction:AuctionRepo {
        return AuctionRepo()
    }
    
    func all(myBids:Bool? = nil,myAuction:Bool? = nil,completion:@escaping(Result<BaseResponse<[FavoriteModel]>,Error>)->Void) {
        auction.request(target: .all(myBids: myBids ?? false, myAuction: myAuction ?? false), completion: completion)
    }
    
    func showOfficialAuction(auction_id:String,completion:@escaping(Result<BaseResponse<AuctionDetailsModel>,Error>)->Void) {
        auction.request(target: .showOfficialAuction(auction_id: auction_id), completion: completion)
    }
    
    func show(auction_id:String,completion:@escaping(Result<BaseResponse<AuctionDetailsModel>,Error>)->Void) {
        auction.request(target: .show(auction_id: auction_id), completion: completion)
    }
    
    func toggleFavorite(auction_id:String,completion:@escaping(Result<BaseResponse<FavoriteModel>,Error>)->Void) {
        auction.request(target: .toggleFavorite(auction_id: auction_id), completion: completion)
    }
    
    func favorites( completion:@escaping(Result<BaseResponse<[FavoriteModel]>,Error>)->Void) {
        auction.request(target: .favorites, completion: completion)
    }
    
    func addBid(auction_id:String,price:String, completion:@escaping(Result<BaseResponse<FavoriteModel>,Error>)->Void) {
        auction.request(target: .addBid(auction_id: auction_id, price: price), completion: completion)
    }
    
    func filterAuctions(search:String? = nil , byCategoryId:String? = nil,code:String? = nil,status:String? = nil,priceFrom:String? = nil,priceTo:String? = nil,endAt:String? = nil,endFrom:String? = nil, completion:@escaping(Result<BaseResponse<[CategoryAuctions]>,Error>)->Void) {
        auction.request(target: .auctionsFilter(search: search, byCategoryId: byCategoryId, code: code, status: status, priceFrom: priceFrom, priceTo: priceTo, endAt: endAt, endFrom: endFrom), completion: completion)
    }
}
