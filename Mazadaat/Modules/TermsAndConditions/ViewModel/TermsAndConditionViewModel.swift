//
//  TermsAndConditionViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 09/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class TermsAndConditionViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    
    var isPrivacyAndPolicy:Bool
    var terms:String = CoreData.shared.settings?.terms ?? ""
    var privacy:String = CoreData.shared.settings?.privacy ?? ""
    init(isPrivacyAndPolicy:Bool) {
        self.isPrivacyAndPolicy = isPrivacyAndPolicy
    }
}

