//
//  SliderModel.swift
//  Mazadaat
//
//  Created by Sharaf on 03/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
struct SlidersModel: Codable {
    var id: Int?
    var url: String?
    var image: String?
    var type: TypeEnum?
}
enum TypeEnum: String, Codable {
    case advertisement = "advertisement"
    case auction = "auction"
    case place = "place"
    case subscription = "subscription"
}
