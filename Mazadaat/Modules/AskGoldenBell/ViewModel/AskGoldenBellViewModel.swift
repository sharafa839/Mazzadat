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

    func getGoldenBell(id:Int = 0) {
        index(id: id) { [weak self] result in
           
            switch result {
            case .success(let response):
                guard let index = response.response?.data else {return}
                self?.onSuccessGetAllAds.accept(index.allAdvertisement ?? [])
                guard var cats = index.advertisementCategory else {return}
                guard let indeci = cats.firstIndex(where: {$0.id == id}) else {return}
                cats[indeci].selected = true
                
                self?.onSuccessGetAllCats.accept(cats)
                
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
     func change(id:Int) {
        index(id: id) { [weak self] result in
           
            switch result {
            case .success(let response):
                guard let index = response.response?.data else {return}
                self?.onSuccessGetAllAds.accept(index.allAdvertisement ?? [])
                guard var cats = index.advertisementCategory else {return}
               
                guard let trus =  cats.firstIndex(where: {$0.selected == true}) else {return}
                cats[trus].selected = false
                guard let indeci = cats.firstIndex(where: {$0.id == id}) else {return}
                cats[indeci].selected = true
                self?.onSuccessGetAllCats.accept(cats)
                
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}

