//
//  LoginAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 12/25/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class LoginAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let story = UIStoryboard(name: "Auth", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "authTab")
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
