//
//  AuctionsViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class AuctionsDetailsViewModel:AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var auctionDetails = PublishSubject<AuctionDetailsModel>()
    var auctionDetailArray = BehaviorRelay<[AuctionDetail]>(value: [])
    var id:String
    var type:String
    var price:String?
    var isOfficialAuction:Bool
    var onSuccessFavorite = PublishSubject<FavoriteModel>()
    var verifyWithNafath = PublishSubject<Void>()
    var placeId:String
    init(id:String,type:String,isOfficialAuction:Bool,placeId:String?) {
        self.id = id
        self.type = type
        self.isOfficialAuction = isOfficialAuction
        self.placeId = placeId ?? ""
    }
    
    func getAuctionsDetails() {
        onLoading.accept(true)
        show(auction_id: id) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let auction = response.response?.data else {return}
                self?.auctionDetails.onNext(auction)
                self?.auctionDetailArray.accept(auction.auctionDetails ?? [])
                self?.price = auction.price ?? ""
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func getOfficialAuction() {
        onLoading.accept(true)
        showOfficialAuction(auction_id: id) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let auction = response.response?.data else {return}
//                self?.detectIsAllowToBidding(auction: auction)
                self?.auctionDetails.onNext(auction)
                self?.auctionDetailArray.accept(auction.auctionDetails ?? [])
                self?.price = auction.price ?? ""
                
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
     func detectIsAllowToBidding(auction:AuctionDetailsModel)->Bool {
         if auction.auctionVisitors == "official" {
             if HelperK.getVerification(){
                 return true
             }else {
                 onError.onNext("notAllowedForAllUsers")
                 verifyWithNafath.onNext(())
                 return false
             }
          
         }else {
             return true
         }

    }
    
    func toggleFavorites() {
        toggleFavorite(auction_id: id) { [weak self] result in
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

