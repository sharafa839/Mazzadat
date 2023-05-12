//
//  SortingModel.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class AuctionSortingViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    let sortingDataSource = [SortingModel(title: "Default".localize, selected: true),
                             SortingModel(title: "priceAscending".localize, selected: false),
                             SortingModel(title: "priceDescending".localize, selected: false),
                             SortingModel(title: "recently".localize, selected: false),
                             SortingModel(title: "oldest".localize, selected: false),]
}

struct SortingModel {
    var title:String
    var selected:Bool
}
