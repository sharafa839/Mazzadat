//
//  WellcomeSplashVC.swift
//  Mazadaat
//
//  Created by macbook on 2/18/21.
//  Copyright © 2021 macbook. All rights reserved.
//

import UIKit

class WellcomeSplashVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblDesc: UILabel!
    var ind = 0
    
    var imgesgArry = [#imageLiteral(resourceName: "Group 55062W-1"),#imageLiteral(resourceName: "Group 1341")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.page = 2
        self.img.image = imgesgArry[ind]
        AppData.firstLogin = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func skip(_ sender: Any) {
        let story = UIStoryboard(name: "Auth", bundle:nil)
               let vc = story.instantiateViewController(withIdentifier: "SplashVC")
               UIApplication.shared.windows.first?.rootViewController = vc
               UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        if ind < 1 {
            ind += 1
            self.img.image = imgesgArry[ind]
            self.pageControl.currentPage = ind
            
            
        }else{
     
            let story = UIStoryboard(name: "Auth", bundle:nil)
                   let vc = story.instantiateViewController(withIdentifier: "SplashVC")
                   UIApplication.shared.windows.first?.rootViewController = vc
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
