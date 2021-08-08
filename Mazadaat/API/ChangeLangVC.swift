////
////  ChangeLangVC.swift
////  ExpectationsKing
////
////  Created by macbook on 9/27/20.
////  Copyright © 2020 macbook. All rights reserved.
////
//
//import UIKit
//
//class ChangeLangVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func closeBtn(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    @IBAction func arabBtn(_ sender: Any) {
//        UserDefaults.standard.set("ar", forKey: "lang")
//                     
//                     L102Language.setAppleLAnguageTo(lang: "ar")
//                     UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        
//            L102Localizer.DoTheMagic()
//
//                     let story = UIStoryboard(name: "Main", bundle:nil)
//                        let vc = story.instantiateViewController(withIdentifier: "tab")
//                        UIApplication.shared.windows.first?.rootViewController = vc
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//    
//    @IBAction func engBtn(_ sender: Any) {
//        UserDefaults.standard.set("en", forKey: "lang")
//                     
//                     L102Language.setAppleLAnguageTo(lang: "en")
//                     UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        L102Localizer.DoTheMagic()
//
//                     let story = UIStoryboard(name: "Main", bundle:nil)
//                        let vc = story.instantiateViewController(withIdentifier: "tab")
//                        UIApplication.shared.windows.first?.rootViewController = vc
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
