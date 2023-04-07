//
//  CartModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation


// MARK: - Payload
struct CartPayload: Codable {
    var userID: Int?
    var status: String?
    var products: [Product]?
    var total: String?
}

// MARK: - Product
struct Product: Codable {
    var cartID, productID: Int?
    var quantity, enTitle, arTitle: String?
    var image: String?
    var price, total: String?

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case productID, quantity
        case enTitle = "en_title"
        case arTitle = "ar_title"
        case image, price, total
    }
}
