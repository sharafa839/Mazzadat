//
//  NotificationsModel.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
// MARK: - Datum
struct NotificationsModel: Codable {
    var id: Int?
    var title: String?
    var message: String?
    var refID, type: Int?
    var readAt: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, message
        case refID = "ref_id"
        case type
        case readAt = "read_at"
        case createdAt = "created_at"
    }
}
