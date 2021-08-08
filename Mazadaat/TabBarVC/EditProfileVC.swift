//
//  EditProfileVC.swift
//  Mazadaat
//
//  Created by macbook on 11/14/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var userData: userOB?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
title = "تعديل حسابي"
        
        getUser()
        // Do any additional setup after loading the view.
    }
    
    
    func getUser(){
            DataClient.getMyProfile(success: { (dict) in
   
             self.email.text = dict.email ?? ""
             self.name.text = dict.name ?? ""
                self.phone.text = dict.mobile ?? ""
             
             
             
                 }, failure: { (err) in
                     
                 self.errorAlert(title: "Alert", body:  err)
                     
                 })

        }
    func EditProfile(){
        
        if name.text == "" {
            
            self.errorAlert(title: "تنبيه", body: "الرجاء كتابة الاسم")
          return
        }
        
        
        
        if phone.text == "" {
                   
                   self.errorAlert(title: "تنبيه", body: "الرجاء كتابة رقم الهاتف")
                 return
               }
               
        
        if email.text == "" {
                   
                   self.errorAlert(title: "تنبيه", body: "الرجاء كتابة البريد الالكتروني")
                 return
               }
               
        
  
               
        
        
        DataClient.editProfile(name: name.text!, email: email.text!, mobile: phone.text!, success: { (dict) in
          
            self.userData = dict
            
            self.email.text = dict.email ?? ""
                       self.name.text = dict.name ?? ""
                          self.phone.text = dict.mobile ?? ""
                       
            self.toastAlert(title: "تم تحديث البيانات بنجاح")
             }, failure: { (err) in
                 
                                self.errorAlert(title: "Alert", body:  err)
                 
             })

    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
EditProfile()
        
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
