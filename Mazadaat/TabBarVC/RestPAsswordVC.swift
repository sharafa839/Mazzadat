//
//  RestPAsswordVC.swift
//  Mazadaat
//
//  Created by macbook on 12/9/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class RestPAsswordVC: UIViewController {

    @IBOutlet weak var confirmNowPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var txtNowPAss: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func restPassTapped(_ sender: Any) {
        
        if confirmNowPass.text == "" {
            
            self.errorAlert(title: "تنبيه", body: "الرجاء تأكيد كلمة المرور")
            return
        }
        
        if newPass.text == "" {
            
            self.errorAlert(title: "تنبيه", body: "الرجاء كتابة كلمة المرور الجديدة")
            return
        }
        
        
        if txtNowPAss.text == "" {
            
            self.errorAlert(title: "تنبيه", body: "الرجاء كتابة كلمة المرور الحالية")
            return
        }
        
        chnagePass()
    }
    
    
    func chnagePass(){
        
        DataClient.restPass(oldPass: self.txtNowPAss.text!, newPass: self.newPass.text!,success: { (dict) in
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
                    vc?.modalTransitionStyle   = .crossDissolve;
                    vc?.modalPresentationStyle = .overCurrentContext
                    vc?.modalPresentationStyle = .overCurrentContext
                    vc?.titleStr = "تم"
                    vc?.titleDec = "تم تغير كلمة المرور بنجاح"
                
            vc?.isRestPass = true
            vc?.isHide = true
                    vc?.ConfirmBtnStr = "اغلاق"
                    
                    self.present(vc!, animated: true, completion: nil)
            
            
              }, failure: { (err) in
                  
                                 self.errorAlert(title: "Alert", body:  err)
                  
              })

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
