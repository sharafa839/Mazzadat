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
    var onSuccessGetNotification = BehaviorRelay<[NotificationsModel]>(value: [])
    var notificationToFilter:[NotificationsModel] = []
    func getNotifications() {
        onLoading.accept(true)
        getAllNotification { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let data = response.response?.data else {return}
                self?.notificationToFilter = data
                self?.getBidding()
            }
        }
    }
    
    func getBidding() {
       
        let biddingNotification = notificationToFilter.filter({$0.type == 6})
        onSuccessGetNotification.accept(biddingNotification)
    }
    
    func getMyAuctions() {
        let biddingNotification = notificationToFilter.filter({$0.type == 2})
        onSuccessGetNotification.accept(biddingNotification)
    }
}

