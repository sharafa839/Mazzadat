//
//  SuccessResetPasswordViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class SuccessResetPasswordViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    
    var success:Bool
    var title:String
    var subTitle:String
    var description:String
    var opensource:openSource
    init(success:Bool,title:String,subtitle:String,descrption:String,type:openSource) {
        self.success = success
        self.title = title
        self.subTitle = subtitle
        self.description = descrption
        self.opensource = type
    }
}

enum openSource {
    case forgetPassword,auction
}
