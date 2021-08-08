//
//  UserManager.swift
//  PunkPandaApp
//
//  Created by macbook on 9/5/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import UIKit
import Spring


class UserManager {
    
    static let shared = UserManager()
    struct navgationBar {
        
        static func hideNaveBar(vc:UIViewController,hide: Bool = true){
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = hide
        }
        
        static func barColor(vc:UIViewController,color:UIColor){
             vc.navigationController?.navigationBar.barTintColor = color
             }
        
        static func tinColor(vc:UIViewController,color:UIColor){
        vc.navigationController?.navigationBar.tintColor = color
        }
    }
    
    struct tabBar{
        static func hide(vc:UIViewController){
                  vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                  vc.navigationController?.navigationBar.shadowImage = UIImage()
                  vc.navigationController?.navigationBar.isTranslucent = true
              }
        
        
    }
    
    
    
    
    
     struct setAnimation{
        static func startAnimation(vc:UIViewController,logView: SpringView){
                let duration = CGFloat(1.3)
                let damping = CGFloat(0.9)
                                       let animationTypeLeft = "fadeInLeft"
                                let animationTypeDwon = "fadeInDown"

                              var delay = CGFloat(0.2)
                                       
                              delay += 0.2
                                       logView.delay = delay
                                       logView.animation = animationTypeLeft
                                       logView.duration = duration
                                       logView.damping = damping
                                       logView.animate()
                    
               }
     }
     

}


