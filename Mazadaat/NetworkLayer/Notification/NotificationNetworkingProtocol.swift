//
//  NotificationNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation

protocol NotificationNetworkingProtocol {
    
    func getAllNotification( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    
    func readAllNotification( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
    
    func readNotification(notificationId:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)

}

extension NotificationNetworkingProtocol {
    private var notification:NotificationRepo {
        return NotificationRepo()
    }
    
    func getAllNotification( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        notification.request(target: .all, completion: completion)
    }
    
    func readAllNotification( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        notification.request(target: .readAll, completion: completion)
    }
    
    func readNotification(notificationId:String, completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        notification.request(target: .read(notificationId: notificationId), completion: completion)
    }
}
