//
//  LangAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 12/13/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class LangAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func arabickTapped(_ sender: Any) {
        
        L102Language.setAppleLAnguageTo(lang: "ar")
        
        
        AppData.lang = "ar"
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
       
        
//        let  rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController")
//
//        self.window?.rootViewController = rootVC
//        self.window?.makeKeyAndVisible()
//
        
        
        let story = UIStoryboard(name: "Main", bundle:nil)
               let vc = story.instantiateViewController(withIdentifier: "tab")
               UIApplication.shared.windows.first?.rootViewController = vc
               UIApplication.shared.windows.first?.makeKeyAndVisible()

        
    }
    
    @IBAction func EnglishTapped(_ sender: Any) {
        
        UserDefaults.standard.set("en", forKey: "lang")
        
        L102Language.setAppleLAnguageTo(lang: "en")
        AppData.lang = "en"

        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    
        let story = UIStoryboard(name: "Main", bundle:nil)
               let vc = story.instantiateViewController(withIdentifier: "tab")
               UIApplication.shared.windows.first?.rootViewController = vc
               UIApplication.shared.windows.first?.makeKeyAndVisible()

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
