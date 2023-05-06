//
//  FeedbackViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 01/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift

class FeedbackViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var isEmailView:Bool
    init(isEmailView:Bool) {
        self.isEmailView = isEmailView
    }
}

