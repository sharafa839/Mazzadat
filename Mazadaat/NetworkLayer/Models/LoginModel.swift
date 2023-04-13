//
//  LoginModel.swift
//  Dana
//
//  Created by Sharaf on 20/05/2022.
//


import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginPayload = try? JSONDecoder().decode(LoginPayload.self, from: jsonData)

import Foundation

// MARK: - LoginPayload


// MARK: - DataClass
struct LoginPayload: Codable {
    var id: Int?
    var name, mobile, email: String?
    var mobileVerifiedAt, emailVerifiedAt: String?
    var avatar: String?
    var lat, lng: JSONNull?
    var isSubscribed: Bool?
    var subscriptions: [Subscription]?
    var appLocale: String?
    var notificationCount: Int?
    var accessToken, tokenType: String?

    enum CodingKeys: String, CodingKey {
        case id, name, mobile, email
        case mobileVerifiedAt = "mobile_verified_at"
        case emailVerifiedAt = "email_verified_at"
        case avatar, lat, lng
        case isSubscribed = "is_subscribed"
        case subscriptions = "Subscriptions"
        case appLocale = "app_locale"
        case notificationCount = "notification_count"
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

// MARK: - Encode/decode helpers

@objcMembers class JSONNull: NSObject, Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    override public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
struct Subscription: Codable {
    var id: Int?
    var name, description, price, gainedBalance: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case gainedBalance = "gained_balance"
    }
}
