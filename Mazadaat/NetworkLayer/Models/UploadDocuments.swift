//
//  WishListMode.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation


// MARK: - DataClass
struct UploadDocuments:Codable {
    var id: Int?
    var documentTypeID: String?
    var documentType: DocumentType?
    var expiryDate: String?
    var frontFace, backFace: String?
    enum CodingKeys: String, CodingKey {
        case id
        case documentTypeID = "document_type_id"
        case documentType = "DocumentType"
        case expiryDate = "expiry_date"
        case frontFace = "front_face"
        case backFace = "back_face"
    }
}

// MARK: - DocumentType
struct DocumentType:Codable {
    var id: Int?
    var name: String?
    var image: String?
}
