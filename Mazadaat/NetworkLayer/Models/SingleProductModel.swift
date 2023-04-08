// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let slidersModel = try? newJSONDecoder().decode(SlidersModel.self, from: jsonData)

import Foundation


//
//// MARK: - Payload
//struct SingleProductPayload: Codable {
//    var id: Int?
//    var client, enTitle, arTitle: String?
//    var sku: String?
//    var slug, enDescription, arDescription: String?
//    var enDetails, arDetails: String?
//    var stock, acive, price, new: String?
//    var isUsed, sale: String?
//    var discount: String?
//    var outstock, isDigital: String?
//    var productLink, license: String?
//    var delete, createdAt, updatedAt, categoryID: String?
//    var photo: Photo?
//    var gallery: [Photo]?
//    var category: Category?
//    var media: [Photo]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, client
//        case enTitle = "en_title"
//        case arTitle = "ar_title"
//        case sku, slug
//        case enDescription = "en_description"
//        case arDescription = "ar_description"
//        case enDetails = "en_details"
//        case arDetails = "ar_details"
//        case stock, acive, price, new
//        case isUsed = "is_used"
//        case sale, discount, outstock
//        case isDigital = "is_digital"
//        case productLink = "product_link"
//        case license, delete
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case categoryID = "category_id"
//        case photo, gallery, category, media
//    }
//}
//
//// MARK: - Category
//struct Category: Codable {
//    var id: Int?
//    var enTitle, arTitle: String?
//    var slug: String?
//    var active, createdAt, updatedAt: String?
//    var photo: Int?
//    var media: [Photo]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case enTitle = "en_title"
//        case arTitle = "ar_title"
//        case slug, active
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case photo, media
//    }
//}
//
//// MARK: - Photo
