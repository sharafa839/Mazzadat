//
//  BaseApiHeaders.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol BaseApiHeadersProtocol {
    var commonHeader:[String:String] { get }
}

extension BaseApiHeadersProtocol {
    var baseUrl:URL {
    return URL(string: "")!
    }
    
    var header:[String:String]? {
       return commonHeader
    }
    
    var commonHeader: [String:String] {
        let authorization = AppData.userToken
        var headers:[String:String] = ["":""]
        if authorization != "" {
            headers["Authorization"] = "\(authorization)"
    }
        return headers
}
}


