//
//  CategoriesProductsModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation


// MARK: - Payload
struct CategoriesProductsPayload: Codable {
    var id: Int?
    var enTitle, arTitle, price: String?
    var discount: String?
    var sale, currency, enDescription, arDescription: String?
    var enDetails: String?
    var arDetails, sku: String?
    var stock, new, isUsed, outstock: String?
    var image: String?
    var gallery: [String]?
    var categoryAr, categoryEn, isDigital: String?

    enum CodingKeys: String, CodingKey {
        case id
        case enTitle = "en_title"
        case arTitle = "ar_title"
        case price, discount, sale, currency
        case enDescription = "en_description"
        case arDescription = "ar_description"
        case enDetails = "en_details"
        case arDetails = "ar_details"
        case sku, stock, new
        case isUsed = "is_used"
        case outstock, image, gallery
        case categoryAr = "category_ar"
        case categoryEn = "category_en"
        case isDigital = "is_digital"
    }
}
