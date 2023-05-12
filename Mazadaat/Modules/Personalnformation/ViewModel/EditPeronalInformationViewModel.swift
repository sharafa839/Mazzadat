//
//  EditPeronalInformationViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
import UIKit
class EditPeronalInformationViewModel:AuthNetworkingProtocol,TicketNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccess = PublishSubject<Void>()
    let personalInformationDataSource = BehaviorRelay <[PersonalInformation]>(value:[PersonalInformation(title: Localizations.displayName.localize, value: HelperK.getname(), image: false),PersonalInformation(title: Localizations.phoneNumber.localize, value: HelperK.getphone(),image: true),PersonalInformation(title: Localizations.emilAddress.localize, value: HelperK.getemail(), image: false),PersonalInformation(title: Localizations.yourPassword.localize, value: "********", image: false)])
        var didImageChange = BehaviorRelay<UIImage?>(value: nil)
    
    func getImage() {
        let image = UIImageView()
        image.downlodImage(str: HelperK.getAvatar())
        didImageChange.accept(image.image ?? UIImage(named: "appIcon"))
    }
    
    func updateImage(image:MultiPartItem) {
        onLoading.accept(true)
        updateProfileImage(image: image) { [weak self] result  in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let responsse):
                guard let data = responsse.response?.data else {return}
                HelperK.setUserData(loginPayLoad: data)
                HelperK.saveToken(token: data.accessToken ?? "")
                self?.onSuccess.onNext(())
            }
        }
    }
    
    func requestChangeName(name:String) {
        changeName(name: name) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
               // self?.onSuccess.onNext(())
                HelperK.showSuccess(title: "requestSend", subtitle: "")
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
   
}

struct PersonalInformation {
    var title:String
    var value:String
    var image:Bool
}
