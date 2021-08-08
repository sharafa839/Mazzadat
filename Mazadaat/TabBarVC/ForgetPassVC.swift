//
//  ForgetPassVC.swift
//  Mazadaat
//
//  Created by macbook on 12/23/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class ForgetPassVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        chnagePass()
    }
    
    @IBAction func haveCodeTapped(_ sender: Any) {
        
        UIStoryboard(name: "Auth", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RestPasswordVerfiyVC") as?  RestPasswordVerfiyVC
    
        self.navigationController?.pushViewController(vc!, animated: true)    }
    
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "RestPasswordVerfiyVC") as?  RestPasswordVerfiyVC
         
                self.navigationController?.pushViewController(vc!, animated: true)
            
            

            print("Action")
        }))
     
        self.present(alert, animated: true, completion: nil)
    }
    
    func chnagePass(){
        
        if txtEmail.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال البريد الالكتروني")
            return
        }
        
        DataClient.fprgetPass(email: txtEmail.text!,success: { (dict) in
            
            
            self.showAlertAction(title: "تم".localized, message: "تم ارسال كود التحقق الى بريدك الالكتروني".localized)
            
     
            
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
