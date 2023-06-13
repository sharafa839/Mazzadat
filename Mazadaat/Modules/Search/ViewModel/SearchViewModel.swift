//
//  SearchViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 10/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class SearchViewModel:AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetAuctions = BehaviorRelay<[CategoryAuctions]>(value:[])
    var onSuccessFavorite = PublishSubject<FavoriteModel>()
    var defaultDetails: [CategoryAuctions] = []
    var currentPage:Int = 1
    var to :Int?
    func getCategoryDetails(page:Int,search:String? = nil , code:String? = nil,status:String? = nil,priceFrom:String? = nil,priceTo:String? = nil,endAt:String? = nil,endFrom:String? = nil) {
        onLoading.accept(true)
        filterAuctions(currentPage:page, search: search, byCategoryId: nil, code: code, status: status, priceFrom: priceFrom, priceTo: priceTo, endAt: endAt, endFrom: endFrom) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let response = response.response else {return}
                guard var data = response.data else {return}
                data += self?.onSuccessGetAuctions.value ?? []
                self?.to = response.paging?.lastPage
                
                self?.onSuccessGetAuctions.accept(data)
                
                self?.defaultDetails = response.data ?? []
                
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
                self?.onSuccessFavorite.onNext(data)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
  
}

