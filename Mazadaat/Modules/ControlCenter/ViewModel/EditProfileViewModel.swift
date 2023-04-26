//
//  EditProfileViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 26/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class EditProfileViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    let editProfileDataSource = [["personalInformation","settings"],["contactUs","giveFeedback","FAQ"],["privacyAndPolicy","termsOfUse"]]
    
    
}

