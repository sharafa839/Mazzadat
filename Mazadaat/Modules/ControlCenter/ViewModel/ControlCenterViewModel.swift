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
class ControlCenterViewModel:AuthNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    let onSuccess = PublishSubject<Void>()
    let editProfileDataSource = [[ControlCenter(title: Localizations.personslInformation.localize, round: .top),ControlCenter(title: Localizations.settings.localize, round: .bottom)],[ControlCenter(title:Localizations.contactUs.localize, round: .top),ControlCenter(title: Localizations.giveAFeedback.localize, round: .none),ControlCenter(title: Localizations.faqs.localize, round: .bottom)],[ControlCenter(title: Localizations.privacyPolicy.localize, round: .top),ControlCenter(title: Localizations.termsOfUse.localize, round: .bottom)]]
    
    func logout() {
        onLoading.accept(true)
        logout { [weak self] result in
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

struct ControlCenter {
    var title:String
    var round:Round
}

enum Round {
    case top,bottom,none
}
