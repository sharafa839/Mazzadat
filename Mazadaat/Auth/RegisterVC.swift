////
////  RegisterVC.swift
////  ExpectationsKing
////
////  Created by macbook on 9/13/20.
////  Copyright © 2020 macbook. All rights reserved.
////
//
//import UIKit
//import TransitionButton
////import Spring
//import SwiftGifOrigin
//
//class RegisterVC: UIViewController {
//    
//    @IBOutlet weak var logoImg: UIImageView!
//    @IBOutlet weak var checkBoxBtn: UIButton!
//    @IBOutlet weak var nameTxt: UITextField!
//    @IBOutlet weak var passwordTxt: UITextField!
//    @IBOutlet weak var emailTxt: UITextField!
//    @IBOutlet weak var phoneTxt: UITextField!
//    @IBOutlet weak var spView: SpringView!
//    
//    @IBOutlet weak var registerBtnView: TransitionButton!
//    
//    @IBOutlet weak var privacyLabel: UILabel!
//    var isSelect = false
//    
//    override func viewDidLoad() {
//        UserManager.setAnimation.startAnimation(vc: self, logView: spView)
//        UserManager.tabBar.hide(vc: self)
//        self.navigationItem.backBarButtonItem?.title = ""
//        self.checkBoxBtn.setImage(#imageLiteral(resourceName: "Rectangle 10"), for: .normal)
//
//        logoImg.image = UIImage.gif(name: "logoApp")
//        
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.tapFunction))
//        privacyLabel.isUserInteractionEnabled = true
//        privacyLabel.addGestureRecognizer(tap)
//
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    @objc
//      func tapFunction(sender:UITapGestureRecognizer) {
//          print("tap working")
//        
//        let story = UIStoryboard(name: "Main", bundle:nil)
//        let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
//        vc?.isTerm = false
//        self.navigationController?.pushViewController(vc!, animated: true)
//      }
//
//    func isValidPhone(phone: String) -> Bool {
//        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//        return phoneTest.evaluate(with: phone)
//    }
//    
//    
//    
//    @IBAction func chekBox(_ sender: Any) {
//        if isSelect == true {
//            isSelect = false
//            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "Rectangle 10"), for: .normal)
//        }else{
//            isSelect = true
//            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "Group 55057w"), for: .normal)
//        }
//    }
//    
//    
//    
//    @IBAction func createAccountTapped(_ sender: Any) {
//        
//        registerBtnView.startAnimation()
//        if emailTxt.text == "" {
//            
//            self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                self.errorAlert(title: "تنبيه".localized, body: "الرجاء ادخال البريد الالكتروني".localized)
//                          }
//                
//      
//            return
//        }
//        
//        if nameTxt.text == "" {
//            
//            self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                self.errorAlert(title: "تنبيه".localized, body: "الرجاء ادخال الاسم".localized)                                }
//          
//            return
//        }
//        if phoneTxt.text == "" {
//            
//                      self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                        self.errorAlert(title: "تنبيه".localized, body: "الرجاء ادخال رقم الهاتف".localized)
//                        
//                        
//            }
//   
//            return
//        }
//        
//        
//        if passwordTxt.text == "" {
//            
//                 self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                    self.errorAlert(title: "تنبيه".localized, body: "الرجاء ادخال كلمة المرور".localized)
//                           
//               }
//    
//            return
//        }
//        
//        
//        if isSelect == false {
//            
//            
//               self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                self.errorAlert(title: "تنبيه".localized, body: "الرجاء الموافقة على سياسة الخصوصية".localized)
//                       }
//            
// 
//            return
//        }
//        
//        registerData()
//    }
//    
//    
//    
//    @IBAction func loginVcTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    func registerData(){
//        
//        
//        DataClient.Register(email: emailTxt.text!, password: passwordTxt.text!, name: nameTxt.text!, mobile: phoneTxt.text!,success: { (dict,state) in
//            
//            if state == "" {
//                
//                
//                self.registerBtnView.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
//                  UserDefaults.standard.setUserId(value: dict.id ?? 0)
//                                
//                                AppData.userToken = dict.access_token ?? ""
//                                AppData.username = dict.name ?? ""
//                    AppData.email = dict.email ?? ""
//                                
//                    AppData.isLogin = true
//                                 AppData.userImg = dict.avatar ?? ""
//                                           
//                    if dict.email_verified_at == "" {
//                        AppData.isVeerfiyEmail = false
//                        
////                        let story = UIStoryboard(name: "Auth", bundle:nil)
////                               let vc = story.instantiateViewController(withIdentifier: "VerfiyCodeVC")
////                        
////                        
////                               UIApplication.shared.windows.first?.rootViewController = vc
////                               UIApplication.shared.windows.first?.makeKeyAndVisible()
////                        
////                        
//                        
//                        let storyboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
//                        let startingView = storyboard.instantiateViewController(withIdentifier: "VerfiyCodeVC")
//                        startingView.modalPresentationStyle = .fullScreen
//                        
//                        self.present(startingView, animated: true, completion: nil)
//                    
//                               
//                    }else{
//                        AppData.isVeerfiyEmail = true
//                        
//                        
//                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let startingView = storyboard.instantiateViewController(withIdentifier: "tab")
//                        startingView.modalPresentationStyle = .fullScreen
//                        
//                        self.present(startingView, animated: true, completion: nil)
//                    
//                    print("Login Success")
//
//                    }
//                              
//                                
//                                 }
//                
//              
//                
//            }else{
//                
//                
//                self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//                  self.errorAlert(title: "تنبيه", body: state)
//                              }
//                   
//                
//            }
//            
//            
//        }, failure: { (err) in
//            
//
//            self.registerBtnView.stopAnimation(animationStyle: .shake, revertAfterDelay: 0) {
//              self.errorAlert(title: "", body: "err")
//                          }
//            
//            
//            
//            
//        })
//    }
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
