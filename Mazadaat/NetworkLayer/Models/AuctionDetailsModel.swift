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
    var status, cityID: Int?
       var code, termsConditions, endAt: String?
       var bidsCount: Int?
       var placeName: String?
       var city: City?
       var lng: String?
       var media: [Media]?
       var name, placeDescription, type: String?
       var lastBid: LastBid?
       var id: Int?
       var auctionVisitors: String?
       var auctionDetails: [AuctionDetail]?
       var isFavourite: Bool?
       var minimumBid, lat: String?
       var category: Category?
       var price: String?
       var categoryID: Int?
       var startAt, description: String?

       enum CodingKeys: String, CodingKey {
           case status
           case cityID = "city_id"
           case code
           case termsConditions = "terms_conditions"
           case endAt = "end_at"
           case bidsCount = "bids_count"
           case placeName = "place_name"
           case city = "City"
           case lng
           case media = "Media"
           case name
           case placeDescription = "place_description"
           case type
           case lastBid = "LastBid"
           case id
           case auctionVisitors = "auction_visitors"
           case auctionDetails = "AuctionDetails"
           case isFavourite = "is_favourite"
           case minimumBid = "minimum_bid"
           case lat
           case category = "Category"
           case price
           case categoryID = "category_id"
           case startAt = "start_at"
           case description
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
