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
    case advertisement
}

extension CoreApi:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .advertisement : return EndPoints.Core.advertisements.rawValue
        case .install: return EndPoints.Core.install.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .advertisement : return .get
        case .install: return .get
        }
    }
    
    var task: Task {
        switch self {
        default:return .requestPlain
        }
    }
    
}
