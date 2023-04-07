//
//  ProfileModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation


// MARK: - Payload
struct ProfilePayload: Codable {
    var info: Info?
    var wallet: String?
}

// MARK: - Info
struct Info: Codable {
    var id: Int?
    var name, email: String?
    var emailVerifiedAt: String?
    var phone, government, city, createdAt: String?
    var updatedAt: String?
    var deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case phone, government, city
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}


