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
       var name: String?
       var image: String?
       var documents: Documents?

       enum CodingKeys: String, CodingKey {
           case id, name, image
           case documents = "Documents"
       }
}
// MARK: - DataClass
struct UploadDocuments:Codable {
    var id: Int?
       var name: String?
       var image: String?
       var documents: Documents?

       enum CodingKeys: String, CodingKey {
           case id, name, image
           case documents = "Documents"
       }
}

// MARK: - DocumentType
struct Documents:Codable {
     var id: Int?
     var backFace: String?
     var frontFace, expiryDate: String?

     enum CodingKeys: String, CodingKey {
         case id
         case backFace = "back_face"
         case frontFace = "front_face"
         case expiryDate = "expiry_date"
     }
}


