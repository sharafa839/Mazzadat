//
//  AuctionDetailsModel.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
// MARK: - DataClass
struct AuctionDetailsModel: Codable {
    var id, categoryID: Int?
    var category: Category?
    var cityID: Int?
    var city: City?
    var name, description, lat, lng: String?
    var price, minimumBid, code, startAt: String?
    var endAt, termsConditions: String?
    var auctionDetails: [AuctionDetail]?
    var status, bidsCount: Int?
    var lastBid: LastBid?
    var media: [Media]?
    var isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case category = "Category"
        case cityID = "city_id"
        case city = "City"
        case name, description, lat, lng, price
        case minimumBid = "minimum_bid"
        case code
        case startAt = "start_at"
        case endAt = "end_at"
        case termsConditions = "terms_conditions"
        case auctionDetails = "AuctionDetails"
        case status
        case bidsCount = "bids_count"
        case lastBid = "LastBid"
        case media = "Media"
        case isFavourite = "is_favourite"
    }
}

//// MARK: - AuctionDetail
//struct AuctionDetail: Codable {
//    var id: Int?
//    var name, value: String?
//}
//
//// MARK: - Category
//struct Category: Codable {
//    var id: Int?
//    var name: String?
//    var image: String?
//    var auctionCount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, image
//        case auctionCount = "auction_count"
//    }
//}
//
//// MARK: - City
//struct City: Codable {
//    var id: Int?
//    var name: String?
//}
//
//// MARK: - Media
//struct Media: Codable {
//    var id: Int?
//    var file: String?
//    var mediaType: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, file
//        case mediaType = "media_type"
//    }
//}
