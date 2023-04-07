//
//  AboutUsModel.swift
//  Dana
//
//  Created by Sharaf on 25/12/2022.
//

import Foundation



// MARK: - Response


// MARK: - Datum
struct FAQModel:Codable {
    var id: Int?
    var name: String?
    var faqs: [FAQElement]?
}

// MARK: - FAQElement
struct FAQElement:Codable {
    var id: Int?
    var question, answer: String?
}
