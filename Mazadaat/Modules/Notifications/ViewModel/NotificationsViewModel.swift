//
//  NotificationsViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//
import Foundation
import RxRelay
import RxSwift
class NotificationsViewModel:NotificationNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    
//    func getNotifications() {
//        getAllNotification { [weak self] result in
//            switch result {
//            case .failure(let error):
//                
//            case .success(let response):
//                
//            }
//        }
//    }
}

