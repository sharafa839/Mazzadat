//
//  TicketViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 06/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class TicketViewModel:TicketNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetData = BehaviorRelay<[TicketModel]>(value: [])
    var onSuccessRunning = BehaviorRelay<[TicketModel]>(value: [])
    var onSuccessClose = BehaviorRelay<[TicketModel]>(value: [])

    func getTickets() {
        onLoading.accept(true)
        getAll { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                let allData = response.response?.data ?? []
                let running = allData.filter({$0.status == 1})
                let close = allData.filter({$0.status == 2})
                self?.onSuccessClose.accept(close)
                self?.onSuccessRunning.accept(running)
                self?.onSuccessGetData.accept(allData)
                
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}

