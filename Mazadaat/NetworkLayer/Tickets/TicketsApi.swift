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
    case all(pageIndex:Int)
    case response(ticketId:String,response:String)
    case store(title:String,message:String,attachment:String)
    case show(ticketId:String)
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
        case .all(let pageIndex):
            return .requestParameters(parameters: ["page":pageIndex,"per_page":"10"], encoding: URLEncoding.default)
        case .changeName(let name):
            return .requestParameters(parameters: ["name":name], encoding: JSONEncoding.default)
        case .response(let ticketId, let response):
            return .requestParameters(parameters: ["ticket_id":ticketId,"response":response], encoding: JSONEncoding.default)
        case .store(let title,let message,let attachment):
            return .requestParameters(parameters: ["title":title,"message":message], encoding: JSONEncoding.default)
        case .show(let ticketId):
            return .requestParameters(parameters: ["ticket_id":ticketId], encoding: URLEncoding.default)
        default : return .requestPlain
        }
        
    }
    
    
}
