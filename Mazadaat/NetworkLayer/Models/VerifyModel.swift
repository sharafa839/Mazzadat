//
//  VerifyModel.swift
//  Mazadaat
//
//  Created by Sharaf on 11/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation

struct VerifyModel: Codable {
    var rejectedMsgs: String?
    var cost, rejected: Int?
    var statusCode, statusDesc, acceptedMsgs, message: String?
    var total: Int?
    var jobID: String?
    var accepted, duplicates: Int?

    enum CodingKeys: String, CodingKey {
        case rejectedMsgs, cost, rejected, statusCode, statusDesc, acceptedMsgs, message, total
        case jobID = "jobId"
        case accepted, duplicates
    }
}
