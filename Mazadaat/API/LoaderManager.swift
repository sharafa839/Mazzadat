//
//  LoaderManager.swift
//  QosoorApp
//
//  Created by يعرب المصطفى on 6/13/20.
//  Copyright © 2020 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit
// this class is like a factory for making the dependency injection of the loader, such that if a new loader has been made, then it would only required to change the type of the loader in this class to use the new one
// this can be called loader adapter
class LoaderManager {
    static var loader: LoaderProtocol = QLoaderView.instance
    
    static func showLoader(){
        DispatchQueue.main.async {
            loader.showLoader()
        }
        
    }
    
    static func hideLoader(){
        DispatchQueue.main.async {
            loader.hideLoader()
        }
    }
    
    static func showLoader(inViewController vc: UIViewController) {
        DispatchQueue.main.async {
            loader.showLoader(inViewContorller: vc)
        }
    }
    
    static func hideLoader(inViewController vc: UIViewController) {
        DispatchQueue.main.async {
            loader.hideLoader(inViewContorller: vc)
        }
    }
}
