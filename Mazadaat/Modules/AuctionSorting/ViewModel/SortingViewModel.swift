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
    let sortingDataSource = [SortingModel(title: "Default", selected: true),
                             SortingModel(title: "priceAscending", selected: false),
                             SortingModel(title: "priceDescending", selected: false),
                             SortingModel(title: "recently", selected: false),
                             SortingModel(title: "oldest", selected: false),]
}

struct SortingModel {
    var title:String
    var selected:Bool
}
