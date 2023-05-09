//
//  PlaceBidViewModel .swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class PlaceBidViewModel:AuctionNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetBid = PublishSubject<Void>()
    var payEntryFee = PublishSubject<Void>()
    var isOfficial:Bool
    var id:String
    var price:Int
    var placeId:String
    var priceChange = BehaviorRelay<Int>(value:0)
    init(placeId:String,id:String,price:Int,isOfficial:Bool) {
        self.id = id
        self.placeId = placeId
        self.price = price
        self.isOfficial = isOfficial
        priceChange.accept(Int(price))
    }
    
    func placeBidding() {
        onLoading.accept(true)
        addBid(auction_id: id, price: "\(priceChange.value)", isOfficial: isOfficial) { [weak self]  result in
            self?.onLoading.accept(false)
            
           
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
                 let errorMessage = error.localizedDescription
                if errorMessage == "لم يتم دفع قيمه شيك الدخول !" || errorMessage == "Entry Fee Not Payed!"{
                    self?.payEntryFee.onNext(())
                }
            case .success(_):
                
                self?.onSuccessGetBid.onNext(())
            }
        }
    }
    
    func adder() {
        priceChange.accept(priceChange.value + 1)
    }
    
    func subtract() {
        guard priceChange.value - 1 > price else {return}
        priceChange.accept(priceChange.value - 1)
    }
}

