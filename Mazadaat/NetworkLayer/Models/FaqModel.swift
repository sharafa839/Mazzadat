//
//  AboutUsModel.swift
//  Dana
//
//  Created by Sharaf on 25/12/2022.
//

import Foundation



// MARK: - Response



// MARK: - Datum
struct FAQModel: Codable {
    var id: Int?
    var name: String?
    var faqs: [FAQElement]?
    var isCollapseSection:Bool? = false
    enum CodingKeys: String, CodingKey {
        case id, name
        case faqs = "Faqs"
    }
}

// MARK: - FAQ
struct FAQElement: Codable {
    var id: Int?
    var question, answer: String?
    var isCollapseRow:Bool? = false
    enum CodingKeys: String, CodingKey {
        case id, question
        case answer 
    }
}
