//
//  AskGoldenBellModel.swift
//  Mazadaat
//
//  Created by Sharaf on 03/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
struct AskGoldenBellModel: Codable {
    var advertisementCategory: [AdvertisementCategory]?
    var allAdvertisement: [AllAdvertisement]?

    enum CodingKeys: String, CodingKey {
        case advertisementCategory = "Advertisement_Category"
        case allAdvertisement = "All_Advertisement"
    }
}

// MARK: - AdvertisementCategory
struct AdvertisementCategory: Codable {
    var id: Int?
    var name, nameAr: String?
    var selected = false

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
    }
}

// MARK: - AllAdvertisement
struct AllAdvertisement: Codable {
    var id: Int?
    var phone, phoneWhatsapp, latitude, longitude: String?
    var name, description: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case id, phone
        case phoneWhatsapp = "phone_whatsapp"
        case latitude, longitude, name
        case description = "description "
        case image
    }
}
