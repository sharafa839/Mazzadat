//
//  DocumentModel.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
// MARK: - Datum
struct DocumentModel: Codable {
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

