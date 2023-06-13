//
//  File.swift
//  Mazadaat
//
//  Created by Sharaf on 16/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//
import Foundation
import RxRelay
import RxSwift
class CategoriesViewModel:AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetAuctions = BehaviorRelay<[CategoryAuctions]>(value:[])
    var onSuccessFavorite = PublishSubject<FavoriteModel>()
    var defaultDetails: [CategoryAuctions] = []
    var Id:String
    var currentPage:Int = 1
    var to :Int?
    var categoryName:String
    init(id:String,title:String) {
        self.Id = id
        self.categoryName = title
    }
    
    func getCategoryDetails(page:Int,search:String? = nil , code:String? = nil,status:String? = nil,priceFrom:String? = nil,priceTo:String? = nil,endAt:String? = nil,endFrom:String? = nil) {
        onLoading.accept(true)
        filterAuctions(currentPage:page,search: search, byCategoryId: Id, code: code, status: status, priceFrom: priceFrom, priceTo: priceTo, endAt: endAt, endFrom: endFrom) { [weak self] result in
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
    
    private func sortByPriceAscending() {
        let auctionWithPrice = onSuccessGetAuctions.value.sorted(by: {(Double($0.price ?? "0") ?? 0.0) > (Double($1.price ?? "0") ?? 0.0)})
        onSuccessGetAuctions.accept(auctionWithPrice)
    }
    
    private func sortByPriceDescending() {
        let auctionWithPrice = onSuccessGetAuctions.value.sorted(by: {(Double($0.price ?? "0") ?? 0.0) < (Double($1.price ?? "0") ?? 0.0)})
        onSuccessGetAuctions.accept(auctionWithPrice)
    }
    
    private func sortRecently() {
        let auctionWithPrice = onSuccessGetAuctions.value.sorted(by: {(Date($0.startAt ?? "0") ?? Date()) < (Date($1.startAt ?? "0") ?? Date())})
        onSuccessGetAuctions.accept(auctionWithPrice)

    }
    
    private func sortOldest() {
        let auctionWithPrice = onSuccessGetAuctions.value.sorted(by: {(Date($0.startAt ?? "0") ?? Date()) > (Date($1.startAt ?? "0") ?? Date())})
        onSuccessGetAuctions.accept(auctionWithPrice)

    }
    
    private func defaultSorting() {
        onSuccessGetAuctions.accept(defaultDetails)
    }
    
    func sorting(by:Int) {
        switch by {
        case 0 :
            defaultSorting()
        case 1:
          sortByPriceAscending()
        case 2:
            sortByPriceDescending()
        case 3:
            sortRecently()
        case 4:
            sortOldest()
        default:
            return
        }
    }
}

