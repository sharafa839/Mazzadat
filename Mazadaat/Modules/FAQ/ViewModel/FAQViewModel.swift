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
    
    func toggleSection(section:Int) {
        var faqModel = onGetFAQ.value
        let sections = faqModel[section]
       
        guard let index = faqModel.firstIndex(where: {$0.id == sections.id}) else {return}
        faqModel[index].isCollapseSection?.toggle()
        onGetFAQ.accept(faqModel)
        
    }
    
    func toggleRow(indexPath:IndexPath) {
        var faqModel = onGetFAQ.value
        var row = faqModel[indexPath.section].faqs?[indexPath.row]
        guard let index = faqModel[indexPath.section].faqs?.firstIndex(where: {$0.id ?? 0 == row?.id ?? 0}) else {return}

        faqModel[indexPath.section].faqs?[index].isCollapseRow?.toggle()
        onGetFAQ.accept(faqModel)
        
    }
}

