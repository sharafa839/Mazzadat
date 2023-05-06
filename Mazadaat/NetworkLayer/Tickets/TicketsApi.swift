//
//  TicketsApi.swift
//  Mazadaat
//
//  Created by Sharaf on 09/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya
enum TicketApi {
    case all
    case response
    case store
    case show
    case changeName(name:String)
}

extension TicketApi :TargetType, BaseApiHeadersProtocol {
    var path: String {
        switch self  {
        case .all :
            return EndPoints.Tickets.all.rawValue
        case .response:
            return EndPoints.Tickets.response.rawValue

        case .store:
            return EndPoints.Tickets.store.rawValue

        case .show:
            return EndPoints.Tickets.show.rawValue

        case .changeName:
            return EndPoints.Tickets.changeName.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self  {
        case .all :
            return .get
        case .response:
            return .post

        case .store:
            return .post

        case .show:
            return .get

        case .changeName:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        
        case .changeName(let name):
            return .requestParameters(parameters: ["name":name], encoding: JSONEncoding.default)
        default : return .requestPlain
        }
        
    }
    
    
}
