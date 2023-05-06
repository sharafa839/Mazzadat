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




// MARK: - DataClass
struct HolderPlaces: Codable {
    var place: Place?
    var auctions: [Auction]?
}

// MARK: - Auction
struct Auction: Codable {
    var id: Int?
    var name, price, minimumBid, startAt: String?
    var endAt: String?
    var bidsCount: Int?
    var lastBid: LastBid?
    var media: [Media]?
    var isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case minimumBid = "minimum_bid"
        case startAt = "start_at"
        case endAt = "end_at"
        case bidsCount = "bids_count"
        case lastBid = "LastBid"
        case media = "Media"
        case isFavourite = "is_favourite"
    }
}


// MARK: - Place
struct Place: Codable {
    var id: Int?
    var name: String?
    var cover: String?
    var description: String?
    var entryFee: Int?
    var auctionTime: String?
    var brochure, terms: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, cover, description
        case entryFee = "entry_fee"
        case auctionTime = "auction_time"
        case brochure, terms, type
    }
}

