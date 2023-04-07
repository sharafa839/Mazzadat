//
//  AboutUsModel.swift
//  Dana
//
//  Created by Sharaf on 25/12/2022.
//

import Foundation

// MARK: - Payload
struct AboutPayload: Codable {
    let id: Int
    let title, titleAr, aboutEn, aboutAr: String
    let termsTitleEn, termsEn, termsArTitle, termsAr: String
    let facebook: String
    let twitter, instagram: String
    let snapchat: String?
    let whatsapp: String
    let createdAt, updatedAt: String
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleAr = "title_ar"
        case aboutEn = "about_en"
        case aboutAr = "about_ar"
        case termsTitleEn = "terms_title_en"
        case termsEn = "terms_en"
        case termsArTitle = "terms_ar_title"
        case termsAr = "terms_ar"
        case facebook, twitter, instagram, snapchat, whatsapp
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Encode/decode helpers
