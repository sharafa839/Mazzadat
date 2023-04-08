//
//  CoreNetworkingProtocol.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol CoreNetworkingProtocol {
    func install( completion:@escaping(Result<BaseResponse<CoreAppModel>,Error>)->Void)
    func advertisement( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void)

}

extension CoreNetworkingProtocol {
    private var core:CoreRepo {
        return CoreRepo()
    }
    
    func install( completion:@escaping(Result<BaseResponse<CoreAppModel>,Error>)->Void) {
        core.request(target: .install, completion: completion)
    }
    
    func advertisement( completion:@escaping(Result<BaseResponse<LoginPayload>,Error>)->Void) {
        core.request(target: .advertisement, completion: completion)
    }
    
}
