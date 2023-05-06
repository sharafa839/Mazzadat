//
//  TicketNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 09/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol TicketNetworkingProtocol {
    func changeName(name:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)
}

extension TicketNetworkingProtocol {
    var repo: TicketRepo {
        return TicketRepo()
    }
    
    func changeName(name:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        repo.request(target: .changeName(name: name), completion: completion)
    }
}
