//
//  BasicResponse.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation

enum ResponseStatus:String,Codable {
    case success = "Success"
    case fail = "fail"
}

struct BasicResponse<T:Codable>:Codable {
    let message:[String]?
    let status:ResponseStatus
    let response:T?
    let code:Int
    let paging:Int?
}

enum NetworkServiceType:String {
    case live = "live"
    case test = "test"
}
