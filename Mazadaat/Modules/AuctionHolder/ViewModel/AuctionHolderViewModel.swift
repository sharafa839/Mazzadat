//
//  AuctionHolderViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 14/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class AuctionHolderViewModel:HomeRepo {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetPlaces = BehaviorRelay<[AuctionHolderPlaces]>(value:[])
    var holderId:String
    var auctionHolderImage:String
    var auctionHolderName:String
    var kindOfAuction = BehaviorRelay<[KindOFAuction]>(value:[KindOFAuction(name: Localizations.all.localize, selected: true),KindOFAuction(name: Localizations.running.localize, selected: false),KindOFAuction(name: "upcoming".localize, selected: false),KindOFAuction(name: "expired".localize, selected: false)])
    init(holderId:String,auctionHolderImage:String,auctionHolderName:String) {
        self.holderId = holderId
        self.auctionHolderName = auctionHolderName
        self.auctionHolderImage = auctionHolderImage
    }
     
    func getHolderPlaces(running:Bool?,upcoming:Bool?,expired:Bool?) {
        onLoading.accept(true)
        holderPlaces(holderID: holderId, running: running, upcoming: upcoming, expired: expired) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let data = response.response?.data else {return}
                self?.onSuccessGetPlaces.accept(data)
            }
        }
    }
}

struct KindOFAuction {
    var name:String
    var selected:Bool
}
