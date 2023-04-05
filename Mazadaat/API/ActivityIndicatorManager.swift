//
//  ActivityIndicatorManager.swift
//  kindergarten
//
//  Created by Amar Amassi  on 4/17/18.
//  Copyright © 2018 Amar Amassi . All rights reserved.
//

import Foundation

class ActivityIndicatorManager: NSObject {
    
    public class func start(_ title: String = ""){


        LoaderManager.showLoader()
    }
    
    public class func stop(){
//        RappleActivityIndicatorView.stopAnimating()
        LoaderManager.hideLoader()

    }
    
    public class func showProgress(progress :  Float){
RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)    }
}
