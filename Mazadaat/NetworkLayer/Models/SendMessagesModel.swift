//
//  SendMessagesModel.swift
//  Mazadaat
//
//  Created by Sharaf on 15/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation


// MARK: - DataClass
struct SendMessageModel: Codable {
    var senderType, messages: String?
    var chatID: Int?
    var isRead: Bool?
    var auctionID: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case senderType = "sender_type"
        case messages
        case chatID = "chat_id"
        case isRead = "is_read"
        case auctionID = "auction_id"
        case id
    }
}
