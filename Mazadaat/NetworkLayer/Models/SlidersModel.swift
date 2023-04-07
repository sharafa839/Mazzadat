//
//  SlidersModel.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation



// MARK: - Payload
struct SlidersPayload: Codable {
    var id: Int?
    var createdAt, updatedAt: String?
    var image, responsive, media: [Image]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image, responsive, media
    }
}

// MARK: - Image
struct Image: Codable {
    var id: Int?
    var modelType: String?
    var modelID, uuid: String?
    var collectionName: String?
    var name, fileName: String?
    var mimeType: String?
    var disk, conversionsDisk: String?
    var size: String?
    var manipulations: [String]?
    var customProperties: CustomProperties?
    var responsiveImages: [String]?
    var orderColumn, createdAt, updatedAt: String?
    var url: String?
    var thumbnail, preview: String?

    enum CodingKeys: String, CodingKey {
        case id
        case modelType = "model_type"
        case modelID = "model_id"
        case uuid
        case collectionName = "collection_name"
        case name
        case fileName = "file_name"
        case mimeType = "mime_type"
        case disk
        case conversionsDisk = "conversions_disk"
        case size, manipulations
        case customProperties = "custom_properties"
        case responsiveImages = "responsive_images"
        case orderColumn = "order_column"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url, thumbnail, preview
    }
}

