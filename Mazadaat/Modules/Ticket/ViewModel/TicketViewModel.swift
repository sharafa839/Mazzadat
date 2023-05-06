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
    func getTickets() {
        onLoading.accept(true)
        getAll { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccessGetData.accept(response.response?.data ?? [])
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}

