//
//  FAQViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 06/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
class FAQViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var onGetFAQ = BehaviorRelay<[FAQModel]>(value: [])
    
    
    func getFAQ() {
        self.onLoading.accept(true)
        faqs { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                self?.onGetFAQ.accept(response.response?.data ?? [])
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func toggleSection(indexPath:IndexPath) {
        var faqModel = onGetFAQ.value
        var sections = faqModel[indexPath.section]
        sections.isCollapseSection.toggle()
        onGetFAQ.accept(faqModel)
        
        
    }
}

