//
//  SplashViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxSwift
class SplashViewModel:CoreNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onSuccess = PublishSubject<Route>()
    var onError = PublishSubject<String>()
    
    func getCore() {
        install { [weak self] value in
            switch value {
            case .success(let response):
                guard let core = response.response?.data else {return}
                CoreData.shared.essentials = core.essentials
                CoreData.shared.documentsTypes  = core.documentsTypes
                CoreData.shared.countries = core.countries
                CoreData.shared.bankAccounts = core.bankAccounts
                CoreData.shared.categories = core.categories
                CoreData.shared.settings = core.settings
                self?.setRoot()
                    
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    private func setRoot() {
        if HelperK.checkFirstTime() {
            if HelperK.checkUserToken() {
                onSuccess.onNext(.home)
            }else{
                onSuccess.onNext(.login)
            }
        }else {
            onSuccess.onNext(.onBoarding)
        }
    }
}

enum Route {
case home,login,onBoarding
}

class CoreData {
   static let shared = CoreData()
    var settings: Settings?
    var subscriptions: [Subscription]?
    var bankAccounts: [BankAccount]?
    var categories: [Category]?
    var countries: [Country]?
    var documentsTypes: [Category]?
    var essentials: Essentials?
    
    func destory() {
        settings = nil
        subscriptions = nil
        bankAccounts = nil
        categories = nil
        countries = nil
        documentsTypes = nil
        essentials = nil
    }
}
