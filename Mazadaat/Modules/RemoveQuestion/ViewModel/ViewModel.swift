//
//  ViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 11/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class RemoveViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var type:RemoveControllerCases
    
    init(type:RemoveControllerCases) {
        self.type = type
    }
}

