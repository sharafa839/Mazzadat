
import Foundation


struct FavoriteModel: Codable {
    var id: Int?
    var categoryID:Int?
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

// MARK: - AuctionDetail
struct AuctionDetail: Codable {
    var id: Int?
    var name, value: String?
}

