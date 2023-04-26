//
//  AuctionsFilterViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class AuctionsFilterViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var dateFrom = BehaviorRelay<String?>(value:nil)
    var dateTo = BehaviorRelay<String?>(value:nil)
    var priceFrom = BehaviorRelay<String?>(value:nil)
    var priceTo = BehaviorRelay<String?>(value:nil)
    var code = BehaviorRelay<String?>(value:nil)
    

}

