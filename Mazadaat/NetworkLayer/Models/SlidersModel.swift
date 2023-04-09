//
//  SlidersModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation



// MARK: - Datum
struct SliderModel: Codable {
    var id, categoryID: Int?
    var category: Categorys?
    var cityID: Int?
    var city: Citys?
    var name, description, lat, lng: String?
    var price, minimumBid, code, startAt: String?
    var endAt, termsConditions: String?
    var auctionDetails: [String]?
    var status, bidsCount: Int?
    var lastBid: String?
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

// MARK: - Category
struct Categorys: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var auctionCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case auctionCount = "auction_count"
    }
}

// MARK: - City
struct Citys: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Media
struct Media: Codable {
    var id: Int?
    var file: String?
    var mediaType: Int?

    enum CodingKeys: String, CodingKey {
        case id, file
        case mediaType = "media_type"
    }
}

// MARK: - Paging
struct Paging: Codable {
    var total, perPage, currentPage, lastPage: Int?
    var from, to: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case from, to
    }
}

// MARK: - Encode/decode helpers
