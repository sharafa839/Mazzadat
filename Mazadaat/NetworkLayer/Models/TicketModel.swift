//
//  TicketModel.swift
//  Mazadaat
//
//  Created by Sharaf on 06/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
struct TicketModel: Codable {
    var status, id: Int?
    var title, message: String?
    var ticketResponses: [TicketResponse]?
    var attachment: String?

    enum CodingKeys: String, CodingKey {
        case status, id, title, message
        case ticketResponses = "TicketResponses"
        case attachment
    }
}
// MARK: - TicketResponse
struct TicketResponse: Codable {
    var id: Int?
    var response: String?
    var senderType: Int?

    enum CodingKeys: String, CodingKey {
        case id, response
        case senderType = "sender_type"
    }
}