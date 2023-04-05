////
////  LoginVC.swift
////  ExpectationsKing
////
////  Created by macbook on 9/13/20.
////  Copyright © 2020 macbook. All rights reserved.
////
//
//import UIKit
//import TransitionButton
//import Spring
//import SwiftGifOrigin
//class LoginVC: UIViewController {
//    
//    @IBOutlet weak var logoIcon: UIImageView!
//    @IBOutlet weak var logView: SpringView!
//    @IBOutlet weak var passwordTxt: UITextField!
//    @IBOutlet weak var emailTxt: UITextField!
//    @IBOutlet weak var logBtn: TransitionButton!
//    
//    @IBOutlet weak var logBtnView: TransitionButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NaveBarManager.navgationBar.hideNaveBar(vc: self)
//        UserManager.setAnimation.startAnimation(vc: self, logView: logView)
// 
//        
//        logoIcon.image = UIImage.gif(name: "logoApp")
//    }
//    
//    
//    @IBAction func loginTapped(_ sender: Any) {
//        
//        
//    
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let startingView = storyboard.instantiateViewController(withIdentifier: "tab")
//        startingView.modalPresentationStyle = .fullScreen
//        
//        self.present(startingView, animated: true, completion: nil)
//    
//        
//    }
//    
//    
//    @IBAction func forgetPass(_ sender: Any) {
//        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
//        let startingView = storyboard.instantiateViewController(withIdentifier: "ForgetPassVC")
//        
//        self.navigationController?.pushViewController(startingView, animated: true)
//    }
//    
//    @IBAction func logTapped(_ sender: Any) {
//        
//        logBtnView.startAnimation()
//   
//                     
//                    
//              
//        if  emailTxt.text == ""
//            
//        {
//            
//        self.logBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                          self.errorAlert(title: "تنبيه ", body:  "الرجاء ادخال البريد الالكتروني")
//                   
//               }
//            return
//        }
//            
//        else if(passwordTxt.text?.isEmpty)!{
//            
//            
//            self.logBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//              self.errorAlert(title: "تنبيه ", body:  "الرجاء ادخال كلمة المرور")
//
//                      }
//            
//            
//            return
//        }
//        
//        
//        DataClient.Userlogin( email: self.emailTxt.text!, password: self.passwordTxt.text!, success: { (dict) in
//        
//            
//            
//             
//             self.logBtnView.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
//                    AppData.isLogin = true
//                                          AppData.username = dict.name ?? ""
//                                          AppData.userId = dict.id ?? 0
//                                          AppData.userToken = dict.access_token ?? ""
//                AppData.userImg = dict.avatar ?? ""
//                AppData.email = dict.email ?? ""
//                
//                if dict.email_verified_at == "" {
//                    AppData.isVeerfiyEmail = false
//                    
//                    let story = UIStoryboard(name: "Auth", bundle:nil)
//                           let vc = story.instantiateViewController(withIdentifier: "VerfiyCodeVC")
//                           UIApplication.shared.windows.first?.rootViewController = vc
//                           UIApplication.shared.windows.first?.makeKeyAndVisible()
//                           
//                }else{
//                    AppData.isVeerfiyEmail = true
//                    
//                    
//                    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
//                    UIApplication.shared.windows.first?.rootViewController = newViewcontroller
//                    UIApplication.shared.windows.first?.makeKeyAndVisible()
//                
//                print("Login Success")
//
//                }
//
//          
//                           }
//            
//            
//            
//        }, failure: { (err) in
//            
//                         
//            
//            self.logBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                    self.errorAlert(title: "تنبيه | تسجيل الدخول", body:  err)
//
//                            }
//            
//        })
//
//    }
//    
//    
//    
//    
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}
//
