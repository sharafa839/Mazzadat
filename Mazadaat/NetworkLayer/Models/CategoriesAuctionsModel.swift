//
//  CategoriesAuctionsModel.swift
//  Mazadaat
//
//  Created by Sharaf on 18/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation



// MARK: - Datum
struct CategoryAuctions: Codable {
    var id, categoryID: Int?
    var category: Category?
    var cityID: Int?
    var city: City?
    var name, description, lat, lng: String?
    var price, minimumBid: String?
    var code: String?
    var startAt, endAt, termsConditions: String?
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



// MARK: - LastBid
struct LastBid: Codable {
    var id, userID: Int?
    var user: User?
    var price: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case user = "User"
        case price
    }
}

struct User: Codable {
    var id: Int?
    var name, mobile, email: String?
    var avatar, lat, lng: String?
}
