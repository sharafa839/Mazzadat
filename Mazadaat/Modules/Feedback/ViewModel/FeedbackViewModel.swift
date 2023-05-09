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

class FeedbackViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccess = PublishSubject<Void>()

    var isEmailView:Bool
    init(isEmailView:Bool) {
        self.isEmailView = isEmailView
    }
    
    
    func addFeedBack(content:String,message:String) {
        if !isEmailView {
        onLoading.accept(true)
            addFeedback(content: content,message:message) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onSuccess.onNext(())
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    }
}

