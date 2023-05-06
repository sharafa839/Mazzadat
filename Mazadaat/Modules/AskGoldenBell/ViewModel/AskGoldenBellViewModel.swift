//
//  AskGoldenBellViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 03/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class AskGoldenBellViewModel:CoreNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetAllAds = BehaviorRelay<[AllAdvertisement]>(value: [])
    var onSuccessGetAllCats = BehaviorRelay<[AdvertisementCategory]>(value: [])

    func getGoldenBell() {
        index { [weak self] result in
           // self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let index = response.response?.data else {return}
                self?.onSuccessGetAllAds.accept(index.allAdvertisement ?? [])
                self?.onSuccessGetAllCats.accept(index.advertisementCategory ?? [])
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}

