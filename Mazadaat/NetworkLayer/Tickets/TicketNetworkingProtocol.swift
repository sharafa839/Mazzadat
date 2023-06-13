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
    func getAll(page:Int,completion:@escaping(Result<BaseResponse<[TicketModel]>,Error>)->Void)
    func response(id:String,response:String,completion:@escaping(Result<BaseResponse<[TicketModel]>,Error>)->Void)
    func Store(title:String,message:String,attachment:String,completion:@escaping(Result<BaseResponse<AddTicketResponse>,Error>)->Void)
    func show(id:String,completion:@escaping(Result<BaseResponse<TicketModel>,Error>)->Void)
}

extension TicketNetworkingProtocol {
    var repo: TicketRepo {
        return TicketRepo()
    }
    
    func changeName(name:String,completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        repo.request(target: .changeName(name: name), completion: completion)
        
    }
    
    func getAll(page:Int,completion:@escaping(Result<BaseResponse<[TicketModel]>,Error>)->Void) {
        repo.request(target: .all(pageIndex: page), completion: completion)
    }
    
    func response(id:String,response:String,completion:@escaping(Result<BaseResponse<[TicketModel]>,Error>)->Void) {
        repo.request(target: .response(ticketId: id, response: response), completion: completion)
    }
    
    func Store(title:String,message:String,attachment:String,completion:@escaping(Result<BaseResponse<AddTicketResponse>,Error>)->Void) {
        repo.request(target: .store(title: title, message: message, attachment: attachment), completion: completion)
    }
    func show(id:String,completion:@escaping(Result<BaseResponse<TicketModel>,Error>)->Void) {
        repo.request(target: .show(ticketId: id), completion: completion)
    }

}
