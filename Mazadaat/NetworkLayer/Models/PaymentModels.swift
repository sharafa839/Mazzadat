//
//  PaymentModels.swift
//  Dana
//
//  Created by Shgardi on 06/06/2022.
//


import Foundation


// MARK: - Payload
struct PaymentPayload: Codable {
    var url: String?
    var orderNumber: String?
    var oid: Int?
    var sessionID: String?

    enum CodingKeys: String, CodingKey {
        case url
        case orderNumber = "order_number"
        case oid
        case sessionID = "session_id"
    }
}



// MARK: - Payload
struct CallbackPayload: Codable {
    var name: String?
    var unitAmount, quantity: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case unitAmount = "unit_amount"
        case quantity
    }
}
