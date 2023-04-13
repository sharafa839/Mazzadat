//
//  CartModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation


// MARK: - Datum
struct AuctionHolderPlaces: Codable {
    var id: Int?
    var name: String?
    var cover: String?
    var entryFee: Int?
    var auctionTime: String?
    var auctionsCount: Int?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, cover
        case entryFee = "entry_fee"
        case auctionTime = "auction_time"
        case auctionsCount = "auctions_count"
        case type
    }
}
