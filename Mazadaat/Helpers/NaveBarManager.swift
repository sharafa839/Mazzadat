//
//  UserManager.swift
//  PunkPandaApp
//
//  Created by macbook on 9/5/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import UIKit

class NaveBarManager {
    
    struct navgationBar {
        static func hideNaveBar(vc:UIViewController){
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = true
            
        }
        
        static func showNave(vc:UIViewController){
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = false
            
        }
    }
 
}


