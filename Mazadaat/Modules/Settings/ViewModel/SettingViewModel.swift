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
                self?.onSuccess.accept(login)
                CoreData.shared.loginModel = response.response?.data
                
            }
        }
    }
}

