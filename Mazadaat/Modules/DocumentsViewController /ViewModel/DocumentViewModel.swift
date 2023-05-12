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
    var documentDataSource = BehaviorRelay<[UploadDocuments]>(value: [
        UploadDocuments(id: nil, documentTypeID: "1", documentType: DocumentType(id: 1, name: "nationalId", image: ""), expiryDate: "", frontFace: nil, backFace: nil),
    UploadDocuments(id: nil, documentTypeID: "3", documentType: DocumentType(id: 3, name: "drivingLicencse", image: ""), expiryDate: "", frontFace: nil, backFace: nil)])
    
    func getDocuments() {
        onLoading.accept(true)
        documents { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let onLineData = response.response?.data else {return}
                self?.onSuccessGetDocument.accept(onLineData)
//                if onLineData.isEmpty {
//
//                    self?.onSuccessGetDocument.accept(self?.documentDataSource.value ?? [])
//                }else if onLineData.count == 1 {
//                    let item = onLineData.first
//                    if item?.documentTypeID == "1" {
//                        guard var value = self?.onSuccessGetDocument.value else {return}
//                        value.append( UploadDocuments(id: nil, documentTypeID: "3", documentType: DocumentType(id: 3, name: "drivingLicencse", image: ""), expiryDate: "", frontFace: nil, backFace: nil))
//                        self?.onSuccessGetDocument.accept(value )
//                    }else {
//                            guard var value = self?.onSuccessGetDocument.value else {return}
//                            value.append(     UploadDocuments(id: nil, documentTypeID: "1", documentType: DocumentType(id: 1, name: "nationalId", image: ""), expiryDate: "", frontFace: nil, backFace: nil))
//                        self?.onSuccessGetDocument.accept(value )
//                    }
//                }else {
//                    return
//                }
            
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func setDataSSourc() {
        let documets = [UploadDocuments(id: 2, documentTypeID: "1", documentType: DocumentType(id: 1, name: "nationalId", image: ""), expiryDate: "", frontFace: nil, backFace: nil),UploadDocuments(id: 2, documentTypeID: "3", documentType: DocumentType(id: 3, name: "drivingLicencse", image: ""), expiryDate: "", frontFace: nil, backFace: nil)]
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
        }    }
}

