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
    var baseURL:URL {
    return URL(string: "")!
    }
    
    var headers:[String:String]? {
       return commonHeader
    }
    
    var commonHeader: [String:String] {
        let authorization = AppData.userToken
        var header:[String:String] = ["":""]
        if authorization != "" {
            header["Authorization"] = "\(authorization)"
    }
        return header
}
}


