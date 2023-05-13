//
//  SettingViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 08/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class SettingViewModel:AuthNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccess = BehaviorRelay<LoginPayload?>(value:nil)
    func editNotification(autionAlert:Bool?,bidUpdates:Bool?,promotion:Bool?,auctionEndingSoon:Bool?) {
        onLoading.accept(true)
        setupNotification(autionAlert: autionAlert, bidUpdates: bidUpdates, promotion: promotion, auctionEndingSoon: auctionEndingSoon) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
                
            case .success(let response):
                guard let login = response.response?.data else {return}
                
                self?.getMe()
            }
        }
    }
    
    func getMe() {
        me { [weak self] result in
            switch result {
            case .success(let response):
                guard let loginModel = response.response?.data else {return}
                CoreData.shared.personalSubscription = loginModel.subscriptions ?? []
                CoreData.shared.loginModel = loginModel
                HelperK.saveToken(token: loginModel.accessToken ?? "" )
            case .failure(let error):
              return
                //self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}

