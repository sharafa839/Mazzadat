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
    let profileDataSource = [ProfileModel(title: "myDocuments", subTitle: "nationalIdAndDrivenLicense", image: ""),
                            ProfileModel(title: "myTickets", subTitle: "YourTTicketOfFollowingUpMyIssuesAndInquires.", image: ""),
                            ProfileModel(title: "chat", subTitle: "YourTTicketOfFollowingUpMyIssuesAndInquires", image: ""),
                            ProfileModel(title: "plans", subTitle: "chooseTheRightPlanThatSuitsYourNeedsAndBudget.", image: ""),
                             ProfileModel(title: "exploreGBAWorld", subTitle: "aboutGBACommunitySocialMediaFAQsTermsOfUseAndPrivacPolicy.", image: "")]
}

