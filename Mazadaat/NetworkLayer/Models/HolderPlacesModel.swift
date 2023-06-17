//
//  CartModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation
import UIKit


// MARK: - Datum
struct AuctionHolderPlaces: Codable {
    var id: Int?
    var name: String?
    var cover: String?
    var entryFee: Int?
    var auctionTime: String?
    var endAuctionTime:String?
    var auctionsCount: Int?
    var type: String?
    var toUiModel:AuctionHolderPlacesUIModel {
        AuctionHolderPlacesUIModel(self)
    }
    enum CodingKeys: String, CodingKey {
        case id, name, cover
        case entryFee = "entry_fee"
        case auctionTime = "auction_time"
        case auctionsCount = "auctions_count"
        case endAuctionTime = "end_auction_time"
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
    var lat:String?
    var lng:String?
    enum CodingKeys: String, CodingKey {
        case id, name, cover, description
        case entryFee = "entry_fee"
        case auctionTime = "auction_time"
        case brochure, terms, type
    }
}


struct AuctionHolderPlacesUIModel {
    var backgroundColor,titleColor: UIColor
    
    var id: Int?
    var name: String
    var cover: String
    var entryFee: String
    var auctionTime: String
    var endAuctionTime:String
    var auctionsCount: String
    var type: String?
    var _startingDate:DateComponents? {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: auctionTime.toDateNew() ?? Date())
        
    }
    
    var _endingDate:DateComponents? {
        Calendar.current.dateComponents([.day,.hour,.minute,.second], from: auctionTime.toDateNew() ?? Date(),to: endAuctionTime.toDateNew() ?? Date())
    }
    
    init(backgroundColor: UIColor, titleColor: UIColor, id: Int? = nil, name: String? = nil, cover: String? = nil, entryFee: String? = nil, auctionTime: String? = nil, endAuctionTime: String? = nil, auctionsCount: String? = nil, type: String? = nil) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.id = id
        self.name = name ?? ""
        self.cover = cover  ?? ""
        self.entryFee = entryFee  ?? ""
        self.auctionTime = auctionTime  ?? ""
        self.endAuctionTime = endAuctionTime  ?? ""
        self.auctionsCount = auctionsCount  ?? ""
        self.type = type  ?? ""
    }
    
    init(_ model:AuctionHolderPlaces) {
        self.auctionTime = model.auctionTime ?? ""
        self.auctionsCount = "\(model.auctionsCount ?? 0)" + " " + "auctionsCount".localize
        self.backgroundColor = AuctionType(rawValue: model.type ?? "")?.backgroundColor ?? .white
        self.titleColor =  AuctionType(rawValue: model.type ?? "")?.titleColor ?? .white
        self.cover = model.cover ?? ""
        self.endAuctionTime = model.endAuctionTime  ?? ""
        self.entryFee = "\( model.entryFee  ?? 0)"
        self.type = model.type ?? ""
        self.id  = model.id ?? 0
        self.name = model.name ?? ""
    }
}
