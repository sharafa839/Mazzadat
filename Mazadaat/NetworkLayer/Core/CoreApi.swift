//
//  CoreApi.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya

enum CoreApi {
    case install
    case index(id:Int)
    case advertisement
}

extension CoreApi:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .advertisement : return EndPoints.Core.advertisements.rawValue
        case .install: return EndPoints.Core.install.rawValue
        case .index(let id):
            return EndPoints.Core.index.rawValue +  "\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .advertisement : return .get
        case .install: return .get
        case .index:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .advertisement:
            return .requestParameters(parameters: ["is_advertisement":true,"page":1,"per_page":50], encoding: URLEncoding.default)
        default:return .requestPlain
        }
    }
    
}
