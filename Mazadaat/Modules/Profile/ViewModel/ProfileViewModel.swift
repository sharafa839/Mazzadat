//
//  ProfileViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
struct ProfileModel {
    var title:String
    var subTitle:String
    var image:String
}

import Foundation
import RxRelay
import RxSwift
class ProfileViewModel {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    let profileDataSource = [ProfileModel(title: Localizations.myDocuments.localize, subTitle: Localizations.drivingLicence.localize + Localizations.nattionalId.localize, image: ""),
                            ProfileModel(title: Localizations.myTickets.localize, subTitle: Localizations.myTickets.localize, image: ""),
                            ProfileModel(title: Localizations.chat.localize, subTitle: Localizations.chat.localize, image: ""),
                            ProfileModel(title: Localizations.plans.localize, subTitle: Localizations.plans.localize, image: ""),
                             ProfileModel(title: Localizations.exploreGoldenBell.localize, subTitle: Localizations.exploreGoldenBell.localize, image: "")]
}

