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

class HomeViewModel:HomeNetworkingProtocol,CoreNetworkingProtocol  {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onSuccessGetImageSlider =   PublishSubject<[SliderModel]>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetCategories =   BehaviorRelay<[Category]>(value: CoreData.shared.categories ?? [])
    var onSuccessGetAuctionHolders =   BehaviorRelay<[AuctionHolder]>(value:[])

    func getAuctionHolders() {
        onLoading.accept(true)
        auctionHolders { [weak self] result in
            
            switch result {
            case .success(let response):
                guard let value = response.response?.data else {return}
                self?.onSuccessGetAuctionHolders.accept(value)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func getSlider() {
        onLoading.accept(true)
        advertisement { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let value = response.response?.data else {return}
                self?.onSuccessGetImageSlider.onNext(value)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    
}
