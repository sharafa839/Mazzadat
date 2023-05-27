//
//  DocumentViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class DocumentViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onSuccrssRemoveDocument = PublishSubject<Void>()

    var onLoading = BehaviorRelay<Bool>(value: false)
    var onSuccessGetDocument = BehaviorRelay<[UploadDocuments]>(value: [])

    
    func getDocuments() {
        onLoading.accept(true)
        documents { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let onLineData = response.response?.data else {return}
                self?.onSuccessGetDocument.accept(onLineData)

            
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
  
    
    func removeDocuments(typeId:String) {
        onLoading.accept(true)
        removeDocuments(type: typeId, front: true, back: true) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.getDocuments()
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
        
    }
}

