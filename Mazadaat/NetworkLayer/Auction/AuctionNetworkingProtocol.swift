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
