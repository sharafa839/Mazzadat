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
    return URL(string: "https://app.golden-auctions.com/")!
    }
    
    var headers:[String:String]? {
       return commonHeader
    }
    
    var commonHeader: [String:String] {
        let checkAuthorization = HelperK.checkUserToken()
        let authorization = checkAuthorization ? HelperK.getUserToken() : ""
        var header:[String:String] = ["":""]
        header["Accept"] = "application/json"
        header["X-localization"] = "ar"
        header["ontent-Type"] = "multipart/form-data"
       
        if authorization != "" {
            header["Authorization"] = "\(authorization)"
    }
        return header
}
}


