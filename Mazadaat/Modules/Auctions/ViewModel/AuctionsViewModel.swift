//
//  AuctionsViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 15/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class AuctionsViewModel:HomeNetworkingProtocol,AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetAuctions = PublishSubject<HolderPlaces>()
    var auctions = BehaviorRelay<[Auction]>(value:[])
    var onAuctionsEmpty = PublishSubject<Void>()
    var places = BehaviorRelay<Place?>(value:nil)
    var onSuccessFavorite = PublishSubject<FavoriteModel>()
    var currentPage:Int = 1
    var to :Int?
    var placeId:String
    var type:String?
    var isOfficial:Bool?
    init(placeId:String) {
        self.placeId = placeId
    }
    
    func getPlaces(page:Int) {
        onLoading.accept(true)
        showHolderPlaces(currentPage:page,placeID: placeId) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let response = response.response else {return}
                guard let data = response.data else {return}
                self?.to = response.paging?.lastPage ?? 0
                self?.onSuccessGetAuctions.onNext(data)
                self?.type = data.place?.type ?? "online"
                self?.isOfficial = data.place?.entryFee != nil || data.place?.entryFee != 0
                if data.auctions?.isEmpty ?? false {
                    self?.onAuctionsEmpty.onNext(())
                }else {
                    guard var auctions = data.auctions else {return}
                    auctions += self?.auctions.value ?? []
                    self?.auctions.accept(auctions )
                }
                
                guard let place = data.place else {return}

                self?.places.accept(place)
            }
        }
    }
    
    func toggleFavorites(auctionId:String) {
        toggleFavorite(auction_id: auctionId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response.response?.data else {return}
                self?.onSuccessFavorite.onNext(data)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}
