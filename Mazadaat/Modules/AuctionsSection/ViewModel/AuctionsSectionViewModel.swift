//
//  AuctionsSectionViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class AuctionSectionViewModel:AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetData = BehaviorRelay<[FavoriteModel]>(value: [])
    var onSuccessGetFavorite = BehaviorRelay<[FavoriteModel]>(value: [])
 
    
    func getMyFavorite() {
        onLoading.accept(true)
        favorites { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccessGetData.accept(response.response?.data ?? [])
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func toggleFavorites(auctionId:String) {
        toggleFavorite(auction_id: auctionId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.response?.data else {return}
                self?.getMyFavorite()
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    
    func getMyAuctions(myBids: Bool?, myAuction: Bool?) {
        onLoading.accept(true)
        all(myBids: myBids, myAuction: myAuction) { [weak self] result in
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

