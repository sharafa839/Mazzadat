//
//  SideMenuVC.swift
//  DSSchool
//
//  Created by mac on 5/9/20.
//  Copyright © 2020 eng.EleyanSaed. All rights reserved.
//

import UIKit
import Toast_Swift
//import SideMenuSwift

class SideMenuVC: UIViewController {

    
    @IBOutlet weak var profileUser: UIImageView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    var window: UIWindow?
    
    var selectId = ""
    
    var indxSelect = -1
    let lang = UserDefaults.standard.string(forKey: "lang")
    let state = UserDefaults.standard.bool(forKey: "status")
    
    
    var sideMenuTitles=["الرئيسية","الاشعارات","ملفاتي المحفوظة","الباقات","الدردشة","اضف اعلانك","سياسة الخصوصية","شروط الاستخدام","الاسئلة الشائعة","مشاركة التطبيق","تقييم التطبيق","اللغة","تسجيل الخروج"]
    
    var sideMenuTitlesOut = ["الرئيسية","سياسة الخصوصية","شروط الاستخدام","الاسئلة الشائعة ","مشاركة التطبيق","تقييم التطبيق","اللغة","تسجيل الدخول"]
     
     
     var icons=[#imageLiteral(resourceName: "browser"),#imageLiteral(resourceName: "bell2"),#imageLiteral(resourceName: "portable-document-formatw"),#imageLiteral(resourceName: "credit-card"),#imageLiteral(resourceName: "comment"),#imageLiteral(resourceName: "iconfinder_5040523_ads_business_finance_financial_management_icon_32px"),#imageLiteral(resourceName: "surface1"),#imageLiteral(resourceName: "iconfinder_ic_info_48px_3669162"),#imageLiteral(resourceName: "iconfinder_question_1814114"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "Group 55128"),#imageLiteral(resourceName: "global"),#imageLiteral(resourceName: "logout")]
    var iconsLogin=[#imageLiteral(resourceName: "browser"),#imageLiteral(resourceName: "surface1"),#imageLiteral(resourceName: "iconfinder_ic_info_48px_3669162"),#imageLiteral(resourceName: "iconfinder_question_1814114"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "Group 55128"),#imageLiteral(resourceName: "global"),#imageLiteral(resourceName: "logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if AppData.lang == "en"{
            sideMenuTitles = ["Home","Notifications","My Documents","Packages","Chat","Add your Ads","Privacy Policy","Terms of use","Common Question","Sahre App","Rate app","Language","LogOut"]
        }
        
                  
                  
                  self.profileUser.sd_setImage(with: AppData.userImg.toURL, placeholderImage: #imageLiteral(resourceName: "istockphoto-1223671392-612x612"), completed: nil)

              
              
        if AppData.isLogin == false {
            self.userNameLabel.text = "زائر".localized
            self.sideMenuTitles = sideMenuTitlesOut
            self.icons = iconsLogin
            editButton.isHidden = true
        }else{
            self.userNameLabel.text = AppData.username
        }
        
//        getUser()
//        if lang == "en"{
//          sideMenuTitles=["My points","My account","My Subscriptions","My expectations","Speical Leagus","Setting","About app","Privcy Policy","Log Out"]
//        }else{
//         sideMenuTitles=["نقاطي","حسابي","اشتراكاتي","توقعاتي","الدوريات الخاصة","الاعدادات","عن التطبيق","سياسة الخصوصية","تسجيل الخروج"]
//        }
//
//        if state == false {
//        sideMenuTitles=["نقاطي","حسابي","اشتراكاتي","توقعاتي","الدوريات الخاصة","الاعدادات","عن التطبيق","سياسة الخصوصية","تسجيل الدخول"]
//        }
        tableView.rowHeight = 50
//        sideMenuController?.revealMenu()
//        hideNave()
        view.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 100)
        
        let ind =  UserDefaults.standard.integer(forKey: "ind") ?? -1
        indxSelect = ind

        // Do any additional setup af,.ter loading the view.
    }
    
    
 
    @IBAction func editTapped(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "EditProfileVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func hideNave(){
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = true
   }
    
    func getUser(){
           DataClient.getMyProfile(success: { (dict) in
             
            if let userImg = dict.avatar {
                
                
                self.profileUser.sd_setImage(with: userImg.toURL, placeholderImage: #imageLiteral(resourceName: "iconfinder_Instagram_UI-18_2315582"), completed: nil)

            }
            self.userNameLabel.text = dict.name ?? ""
            
            
            
            
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
    func showAlertAction(title: String, message: String, buttonTitle:String){
          let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
          alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            AppData.isLogin = false

              let story = UIStoryboard(name: "Auth", bundle:nil)
              let vc = story.instantiateViewController(withIdentifier: "authTab")
              UIApplication.shared.windows.first?.rootViewController = vc
              UIApplication.shared.windows.first?.makeKeyAndVisible()
         
          }))
        
          alert.addAction(UIAlertAction(title: "الغاء", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }

}

extension SideMenuVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? menuCell
        
        cell?.icoImg.image = self.icons[indexPath.row]
        
//         cell?.icoImg.image =  cell?.icoImg.image?.withRenderingMode(.alwaysTemplate)
//          cell?.icoImg.tintColor = UIColor.gray
        cell?.titleLbl.text = self.sideMenuTitles[indexPath.row]
        
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuTitles.count
    }
    
    
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         let cell = tableView.cellForRow(at: indexPath) as? menuCell

        
        
        if AppData.isLogin {
            if indexPath.row == 0 {
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
                
                          UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                
                                 UIApplication.shared.windows.first?.makeKeyAndVisible()
                                 
                
            }else if indexPath.row == 1 {
                
                if AppData.isLogin == false{
                    
                    
                    return
                }
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotVC")
                    self.navigationController?.pushViewController(vc, animated: true)
                                     
                
            }else if indexPath.row == 3 {
                
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "PakagesVC")
            self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.row == 2 {
                let story = UIStoryboard(name: "Main", bundle:nil)
                      let vc = story.instantiateViewController(withIdentifier: "DocumentsVC")
                      self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else  if indexPath.row == 5 {
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "AddTicketVC") as? AddTicketVC
                vc?.isAds = true
                self.navigationController?.pushViewController(vc!, animated: true)
                
              
                
            }else  if indexPath.row == 6 {
                
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else  if indexPath.row == 7{
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
                vc?.isTerm = true
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }else  if indexPath.row == 8 {
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "QestionVC") as? QestionVC
                
                vc?.title  = "الاسئلة الشائعة".localized
                
                self.navigationController?.pushViewController(vc!, animated: true)
                
                
                
                
                
            }else  if indexPath.row == 9{
                
                if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/id1552158103?ls=1&mt=8") {
                    let objectsToShare = [urlStr]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                    if UIDevice.current.userInterfaceIdiom == .pad {
                        if let popup = activityVC.popoverPresentationController {
                            popup.sourceView = self.view
                            popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                        }
                    }

                    self.present(activityVC, animated: true, completion: nil)
                }
                
            }else  if indexPath.row == 10 {
                
                if #available(iOS 10.3, *) {
    //                   SKStoreReviewController.requestReview()

                   } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "id1552158103?") {
                       if #available(iOS 10, *) {
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)

                       } else {
                           UIApplication.shared.openURL(url)
                       }
                   }
                
            }else  if indexPath.row == 11 {
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "LangAlertVC")
             
                vc.modalTransitionStyle   = .crossDissolve;
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
            }else  if indexPath.row == 12 {
                
                
                self.showAlertAction(title: "تسجيل خروج", message: "هل تريد تسجيل الخروج", buttonTitle: "تسجيل الخروج")

            }else if indexPath.row == 4 {
                let story = UIStoryboard(name: "Main", bundle:nil)
                           let vc = story.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
                           self.navigationController?.pushViewController(vc!, animated: true)
            }
        }else{
            if indexPath.row == 0 {
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
                
                          UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                
                                 UIApplication.shared.windows.first?.makeKeyAndVisible()
                                 
                
            }else if indexPath.row == 1 {
                
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else  if indexPath.row == 2 {
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
                vc?.isTerm = true
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }else  if indexPath.row == 3 {
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "QestionVC") as? QestionVC
                
                vc?.title  = "الاسئلة الشائعة".localized
                
                self.navigationController?.pushViewController(vc!, animated: true)
                
                
                
                
                
            }else  if indexPath.row == 4 {
                
                if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/id1552158103?ls=1&mt=8") {
                    let objectsToShare = [urlStr]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                    if UIDevice.current.userInterfaceIdiom == .pad {
                        if let popup = activityVC.popoverPresentationController {
                            popup.sourceView = self.view
                            popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                        }
                    }

                    self.present(activityVC, animated: true, completion: nil)
                }
                
            }else  if indexPath.row == 5 {
                
                if #available(iOS 10.3, *) {
    //                   SKStoreReviewController.requestReview()

                   } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "id1552158103?") {
                       if #available(iOS 10, *) {
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)

                       } else {
                           UIApplication.shared.openURL(url)
                       }
                   }
                
            }else  if indexPath.row == 6 {
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "LangAlertVC")
             
                vc.modalTransitionStyle   = .crossDissolve;
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
            }else  if indexPath.row == 7 {
                
                let story = UIStoryboard(name: "Auth", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "authTab")
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()

            }
        }
        
     
        
//        
//         if indexPath.row == 0 {
//             
//             if state == false {
//                     self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//                 
//                 return
//                 }
//             
//             let story = UIStoryboard(name: "Main", bundle:nil)
//             let vc = story.instantiateViewController(withIdentifier: "MyPointsVC")
//                         self.navigationController?.pushViewController(vc, animated: true)
//
//             
//         }else if indexPath.row == 1 {
//            
//            if state == false {
//                    self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//                
//                return
//                }
//             let story = UIStoryboard(name: "Main", bundle:nil)
//             let vc = story.instantiateViewController(withIdentifier: "MyAccountVC")
//             self.navigationController?.pushViewController(vc, animated: true)
//
//         }else if indexPath.row == 2 {
//         if state == false {
//                 self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//             
//             return
//             }
//                 
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let vc = storyboard.instantiateViewController(withIdentifier: "MySubVC")
//            
//    
//                 
//                 self.navigationController?.pushViewController(vc, animated: true)
//            
//             
//             
//             
//         }  else if indexPath.row == 3{
//        if state == false {
//                self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//            
//            return
//            }
//                 
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//                 
//            vc?.isExpect = true
//    
//                 self.navigationController?.pushViewController(vc!, animated: true)
//             
//            
//             
//             
//         }else if indexPath.row  == 4 {
//          if state == false {
//                  self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//              
//              return
//              }
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let startingView = storyboard.instantiateViewController(withIdentifier: "ExpectionVC")
//            self.navigationController?.pushViewController(startingView, animated: true)
//
//         } else if indexPath.row == 5{
//             if state == false {
//                     self.showAlertAction(title: "تنبيه", message: "يجب عليك تسجيل الدخول للاستخدام التطبيق")
//                 
//                 return
//                 }
//             
//           let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                     let vc = storyboard.instantiateViewController(withIdentifier: "SettingVC")
//  
//            vc.modalTransitionStyle   = .crossDissolve;
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//             
//         }else if indexPath.row  == 5{
//             
//             
//             let id = UserDefaults.standard.string(forKey: "studentId") ?? ""
//             
//             
//             if id == "" {
//                 self.errorAlert(title: "تنبيه", body: "الرجاء اختيار أحد الأبناء")
//                 
//             }else{
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let startingView = storyboard.instantiateViewController(withIdentifier: "StudayTableVCC")
//                 //                                        startingView.modalPresentationStyle = .fullScreen
//                 
//                 
//                 self.navigationController?.pushViewController(startingView, animated: true)
//                 
//                 //                                        self.present(startingView, animated: true, completion: nil)
//                 
//                 
//             }
//             
//             
//             
//         }
//         else if indexPath.row  == 8{
//            UserDefaults.standard.set(false, forKey: "status")
//
//            let story = UIStoryboard(name: "Auth", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "AuthVC")
//            UIApplication.shared.windows.first?.rootViewController = vc
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//             
//         }else if indexPath.row  == 11 {
//             
//             
//             let id = UserDefaults.standard.string(forKey: "studentId") ?? ""
//             
//             if id == "" {
//                 self.errorAlert(title: "تنبيه", body: "الرجاء اختيار أحد الأبناء")
//                 
//             }else{
//                 
//                 
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let startingView = storyboard.instantiateViewController(withIdentifier: "InvoiceVC")
//                 
//                 self.navigationController?.pushViewController(startingView, animated: true)
//             }
//             
//             
//         }else if indexPath.row  == 6 {
//        
//                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                 let startingView = storyboard.instantiateViewController(withIdentifier: "InstallVC") as? InstallVC
//            
//            startingView?.type = ""
//                 
//            self.navigationController?.pushViewController(startingView!, animated: true)
//                 
//             
//             
//             
//             
//         }else if indexPath.row  == 7 {
//            
//                  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                   let startingView = storyboard.instantiateViewController(withIdentifier: "InstallVC") as? InstallVC
//              
//              startingView?.type = "p"
//                   
//              self.navigationController?.pushViewController(startingView!, animated: true)
//                   
//               
//             
//             
//         }else if indexPath.row  == 12 {
//             
//             UserDefaults.standard.set(false, forKey: "status")
//                       
//                       UserDefaults.standard.set(-1, forKey: "ind")
//
//                       
//             let story = UIStoryboard(name: "Wellcome", bundle:nil)
//                        let vc = story.instantiateViewController(withIdentifier: "WellcomeRoot")
//                        UIApplication.shared.windows.first?.rootViewController = vc
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    
//           
//         }
         
     }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? menuCell
        
//        cell?.backView.backgroundColor = UIColor.clear
        cell?.titleLbl.textColor = UIColor.black
        
        cell?.icoImg.image =      cell?.icoImg.image?.withRenderingMode(.alwaysTemplate)
        cell?.icoImg.tintColor = UIColor.black
        
    }
}


