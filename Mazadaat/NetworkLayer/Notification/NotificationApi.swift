//
//  NotificationApi.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Moya
enum NotificationApi {
    case all , readAll
    case read(notificationId:String)
    
}

extension NotificationApi:TargetType,BaseApiHeadersProtocol {
    var path: String {
        switch self {
        case .all:
            return EndPoints.Notifications.all.rawValue
        case .readAll:
            return EndPoints.Notifications.readAll.rawValue

        case .read:
            return EndPoints.Notifications.read.rawValue

        }
    }
    
    var method: Moya.Method {
        switch self {
        default : return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .read(let notificationId):
            return .requestParameters(parameters: ["notification_id":notificationId], encoding: JSONEncoding.default)
        default:return .requestPlain
        }
    }
    
    
}
