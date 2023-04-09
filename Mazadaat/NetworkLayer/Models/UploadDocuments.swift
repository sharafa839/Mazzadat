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
}

// MARK: - DocumentType
struct DocumentType:Codable {
    var id: Int?
    var name: String?
    var image: String?
}
