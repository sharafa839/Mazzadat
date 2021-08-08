//
//  MyInfoVC.swift
//  Mazadaat
//
//  Created by macbook on 11/26/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MyInfoVC: UIViewController  {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var proUserImg: UIImageView!
    
    var userObj: userOB?
    
    var titleStr = ["باقات التأمين","طلب استرداد التأمين","سياسة الخصوصية","مجلد ملفاتي","الدردشة المباشرة","تواصل معنا","تسجيل خروج"]
    
    var icons = [#imageLiteral(resourceName: "pay"),#imageLiteral(resourceName: "008---IT-Request"),#imageLiteral(resourceName: "surface1"),#imageLiteral(resourceName: "google-docs"),#imageLiteral(resourceName: "comment22"),#imageLiteral(resourceName: "phone"),#imageLiteral(resourceName: "logoutaa")]
    var ind = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLbl.text = userObj?.name ?? ""
        self.userEmail.text = userObj?.email ?? ""
        self.proUserImg.sd_setImage(with: userObj?.avatar?.toURL, placeholderImage: #imageLiteral(resourceName: "iconfinder_Instagram_UI-18_2315582"), completed: nil)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NaveBarManager.navgationBar.hideNaveBar(vc: self)
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


extension  MyInfoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as? CatCell
        let  obj = titleStr[indexPath.row]
        
        
        cell?.lblTitle.text = obj
        cell?.img.image = icons[indexPath.row]

        
        if indexPath.row == ind {
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                     cell?.img.tintColor = UIColor.white
                     cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            
        }else{
            
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                         cell?.img.tintColor = UIColor(hex: "FFC200")
                         cell?.backV.backgroundColor = .clear
            
        }
        
        return cell!
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as?
        CatCell
        
        cell?.lblTitle.textColor = UIColor.black

        ind = indexPath.row
        switch indexPath.row {
        case 0:
            print("xx")
             cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
            cell?.img.tintColor = UIColor.white
            cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            
            let story = UIStoryboard(name: "Main", bundle:nil)
               let vc = story.instantiateViewController(withIdentifier: "PakagesVC")
               self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("xx")
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                            cell?.img.tintColor = UIColor.white
                            cell?.backV.backgroundColor = UIColor(hex: "FFC200")
                     
            
            if userObj?.is_subscribed == true {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
                                    vc?.modalTransitionStyle   = .crossDissolve;
                                    vc?.modalPresentationStyle = .overCurrentContext
                                    vc?.modalPresentationStyle = .overCurrentContext
                                    vc?.titleStr = "طلب استرداد تأمين"
                                    vc?.titleDec = "هل أنت متأكد من ابلاغ الادارة برغبتك باسترداد التأمين الخاص بك في التطبيق لدينا؟"
                                   
                vc?.isRecoverMoney = true

                                    vc?.ConfirmBtnStr = "طلب استرداد التأمين"
                                    
                                    self.present(vc!, animated: true, completion: nil)
            }else{
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
                        vc?.modalTransitionStyle   = .crossDissolve;
                        vc?.modalPresentationStyle = .overCurrentContext
                        vc?.modalPresentationStyle = .overCurrentContext
                        vc?.titleStr = "طلب استرداد تأمين"
                        vc?.titleDec = "لايمكنك ارسال طلب استرداد, لايتوفر في  ,حسابك رصيد متوفر حالياً اذا كان هناك خطأ يمكنك مراسلتنا من خلال التذاكر"
                        vc?.isActivealert = true
                vc?.isConfirmHide = true
                vc?.isHide = false
                vc?.cncelViewColor = #colorLiteral(red: 0.979321897, green: 0.6825674772, blue: 0, alpha: 1)

                        vc?.ConfirmBtnStr = "اغلاق"
                        
                        self.present(vc!, animated: true, completion: nil)
            }
         
            

        case 2:
            print("xx")
            
     
                       cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                              cell?.img.tintColor = UIColor.white
                              cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC")
            self.navigationController?.pushViewController(vc, animated: true)
            

        case 3:
            print("xx")
            
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                   cell?.img.tintColor = UIColor.white
                   cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            
            let story = UIStoryboard(name: "Main", bundle:nil)
                  let vc = story.instantiateViewController(withIdentifier: "DocumentsVC")
                  self.navigationController?.pushViewController(vc, animated: true)

        case 4:

            print("xx")
            
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                   cell?.img.tintColor = UIColor.white
                   cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            let story = UIStoryboard(name: "Main", bundle:nil)
                                let vc = story.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
                                self.navigationController?.pushViewController(vc!, animated: true)
            
        case 5:

            
            cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                   cell?.img.tintColor = UIColor.white
                   cell?.backV.backgroundColor = UIColor(hex: "FFC200")
            let story = UIStoryboard(name: "Main", bundle:nil)
                                let vc = story.instantiateViewController(withIdentifier: "TicketsVC") as? TicketsVC
//            vc?.delegate = self
                                self.navigationController?.pushViewController(vc!, animated: true)
            
        case 6:
            
            
            self.showAlertAction(title: "تسجيل خروج", message: "هل تريد تسجيل الخروج", buttonTitle: "تسجيل الخروج")



            
        case 7:

                      print("xx")
                      
                      cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                             cell?.img.tintColor = UIColor.white
            
            AppData.isLogin = false
                                    let story = UIStoryboard(name: "Auth", bundle:nil)
                                               let vc = story.instantiateViewController(withIdentifier: "authTab")
                                               UIApplication.shared.windows.first?.rootViewController = vc
                                               UIApplication.shared.windows.first?.makeKeyAndVisible()

        default:
            break
        }
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

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
                let cell = tableView.cellForRow(at: indexPath) as?
        CatCell
        
        cell?.lblTitle.textColor = UIColor(hex: "707070")

        switch indexPath.row {
        case 0:
            print("xx")
             cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
            cell?.img.tintColor = UIColor(hex: "FFC200")
            cell?.backV.backgroundColor = .clear
        case 1:
            print("xx")
            
           cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                     cell?.img.tintColor = UIColor(hex: "FFC200")
                     cell?.backV.backgroundColor = .clear
        case 2:
            print("xx")
            
            
         cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                     cell?.img.tintColor = UIColor(hex: "FFC200")
                     cell?.backV.backgroundColor = .clear

        case 3:
            print("xx")
         cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                     cell?.img.tintColor = UIColor(hex: "FFC200")
                     cell?.backV.backgroundColor = .clear

        case 4:

            print("xx")
              cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                     cell?.img.tintColor = UIColor(hex: "FFC200")
                     cell?.backV.backgroundColor = .clear
            
        case 5:

                   print("xx")
                     cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                            cell?.img.tintColor = UIColor(hex: "FFC200")
                            cell?.backV.backgroundColor = .clear
            
        case 6:

                   print("xx")
                     cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                            cell?.img.tintColor = UIColor(hex: "FFC200")
                            cell?.backV.backgroundColor = .clear
            
        case 7:

                         print("xx")
                           cell?.img.image = cell?.img.image?.withRenderingMode(.alwaysTemplate)
                                  cell?.img.tintColor = UIColor(hex: "FFC200")
                                  cell?.backV.backgroundColor = .clear
        default:
            break
        }
    }
    
    
}



