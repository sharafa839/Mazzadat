//
//  HomeViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import SwiftUI

class HomeViewModel:HomeNetworkingProtocol,CoreNetworkingProtocol,TransactionNetworkingProtocol  {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onSuccessGetImageSlider =   PublishSubject<[SliderModel]>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetCategories =   BehaviorRelay<[Category]>(value: CoreData.shared.categories ?? [])
    var onSuccessGetAuctionHolders =   BehaviorRelay<[AuctionHolder]>(value:[])
    var onSuccessGetMybalance = BehaviorRelay<Int>(value:0)
    var onSuccesGetSlider = BehaviorRelay<[SlidersModel]>(value: [])
    var onAccessAuction = PublishSubject<(TypeEnum,Int)>()
    func getAuctionHolders() {
       // onLoading.accept(true)
        auctionHolders { [weak self] result in
          //  self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let value = response.response?.data else {return}
                self?.onSuccessGetAuctionHolders.accept(value)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
//    func getSlider() {
//        onLoading.accept(true)
//        advertisement { [weak self] result in
//            self?.onLoading.accept(false)
//            switch result {
//            case .success(let response):
//                guard let value = response.response?.data else {return}
//                self?.onSuccessGetImageSlider.onNext(value)
//            case .failure(let error):
//                self?.onError.onNext(error.localizedDescription)
//            }
//        }
//    }
    
    func getMyBalance() {
       // onLoading.accept(true)
        guard HelperK.checkUserToken() else {return}
        myBalance { [weak self] result in
         //   self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccessGetMybalance.accept(response.response?.data ?? 0)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func getSliders() {
        getSlider { [weak self] result in
            //self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let slider = response.response?.data else {return}
                self?.onSuccesGetSlider.accept(slider)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
     func didTapOnSlider(index:Int) {
        let slider = onSuccesGetSlider.value[index]
        guard let type = slider.type else {return}
       
        
        
        switch type {
        case .advertisement:
            guard let url = slider.url else {return}
            HelperK.openFacebook(facebook: url)
        case .auction,.place,.subscription:
            guard let id = slider.id else {return}
            onAccessAuction.onNext((type,id))
        }
        
    }
    
    
}
