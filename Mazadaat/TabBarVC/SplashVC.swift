//
//  SplashVC.swift
//  Mazadaat
//
//  Created by macbook on 12/26/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    var timer = Timer()

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage.gif(name: "logoApp")

        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
             
        // Do any additional setup after loading the view.
    }
    
    
    @objc func timerAction() {
        

        if AppData.isLogin == true {
            
            if  AppData.isVeerfiyEmail{
                
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
                UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
            }else{
                let story = UIStoryboard(name: "Auth", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "VerfiyCodeVC")
                UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
            }

           
        }else{
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "authTab")
            UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                UIApplication.shared.windows.first?.makeKeyAndVisible()
        }

                 
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
