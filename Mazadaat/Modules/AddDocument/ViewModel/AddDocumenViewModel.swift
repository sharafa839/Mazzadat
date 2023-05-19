//
//  AddDocumenViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class AddDocumentViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var pictures = BehaviorRelay<[[String]]>(value: [])
    var documents:UploadDocuments?
    var onSuccess = PublishSubject<Void>()
    var detectViews = PublishSubject<DetectViews>()
    init(document:UploadDocuments?) {
        self.documents = document
        dataSource()
    }
    
    func dataSource() {
        var photos = pictures.value
        photos.append(contentsOf: [[documents?.frontFace ?? ""] ,[documents?.backFace ?? ""]])
        pictures.accept(photos)
    }
    let imageName = "img-\(CACurrentMediaTime()).png"

    func uploadDocument(frontImage:MultiPartItem,bakeImage:MultiPartItem) {
        uploadDocuments(frontImage: frontImage, backImage: bakeImage, id: documents?.documentType?.id ?? 0) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                self?.onSuccess.onNext(())
            }
        }
        

        
    }
    
    func getViews() {
        if documents == nil {
            detectViews.onNext(.none)
        }else {
            if !(documents?.frontFace?.isEmpty ?? false) && !(documents?.backFace?.isEmpty ?? false) {
                detectViews.onNext(.fillAll)
            }else if (documents?.frontFace?.isEmpty ?? false) && !(documents?.backFace?.isEmpty ?? false) {
                detectViews.onNext(.fillDownOne)
            }else if !(documents?.frontFace?.isEmpty ?? false) && (documents?.backFace?.isEmpty ?? false){
                detectViews.onNext(.fillUpOne)
            }
        }
    }
    
    
    func removeDocuments(front:Bool?,back:Bool?) {
        onLoading.accept(true)
        removeDocuments(type: documents?.documentTypeID ?? "", front: front, back: back) { [weak self] result in
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


enum DetectViews {
    case fillAll
    case fillUpOne
    case fillDownOne
    case none
}
