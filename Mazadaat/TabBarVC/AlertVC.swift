//
//  AlertVC.swift
//  Mazadaat
//
//  Created by macbook on 10/31/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit


enum AlertType{
    case sucess
    case south
    case east
    case west
    
}

protocol MyDataSendingActiveVC {
    func goToActiveVC(myData: String)
}

class AlertVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var confirmView: DesignableView!
    @IBOutlet weak var cancelView: DesignableView!
    var delegate: MyDataSendingDelegateProtocol? = nil
    var activeDelegate: MyDataSendingActiveVC? = nil

    var titleDec = ""
    var titleStr = ""
    var ConfirmBtnStr = ""
    var alertType = AlertType.sucess
    var isActivealert = false
    var isHide = false
    var isConfirmHide = false
    var isRecoverMoney = false
    var cncelViewColor = #colorLiteral(red: 0.4979824424, green: 0.498071909, blue: 0.4979767799, alpha: 1)
    var isRestPass = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cancelView.topColor = cncelViewColor
        cancelView.bottomColor = cncelViewColor
        self.titleLbl.text = titleStr
        self.lblTitle.text = titleDec
        self.confirmBtn.setTitle(ConfirmBtnStr, for: .normal)
        self.confirmBtn.setTitleColor(.white, for: .normal)
        self.confirmView.isHidden = isConfirmHide
        self.cancelView.isHidden = isHide
 
    }
    
   
    @IBAction func confirmBtn(_ sender: Any) {
      

        if isActivealert == true {
            self.activeDelegate?.goToActiveVC(myData: "")
            self.dismiss(animated: true, completion: nil)

            
        }else if isRecoverMoney == true {
            recoverMoney()
            
        }else if isRestPass{
            
                AppData.isLogin = false
                let story = UIStoryboard(name: "Auth", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "authTab")
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
            }
        else{
            self.delegate?.sendDataToFirstViewController(myData: "true")

                  self.delegate?.sendDataToFirstViewController(myData: "")
            self.dismiss(animated: true, completion: nil)

        }
      
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    func recoverMoney(){
          
          DataClient.recoverMoney(success: { (dict) in
    
                       self.showAlertAction(title: "تنبيه", message: "تم الحفظ بنجاح")

              
                }, failure: { (err) in
                    
                    self.errorAlert(title: "تنبيه".localized, body:  "لقد قمت بطلب الاسترداد مسيقاً".localized)
                    
                })

       }
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
                     
                               UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                     
                                      UIApplication.shared.windows.first?.makeKeyAndVisible()
                                              }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
