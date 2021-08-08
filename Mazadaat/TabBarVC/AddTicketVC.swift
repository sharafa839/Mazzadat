//
//  AddTicketVC.swift
//  Mazadaat
//
//  Created by macbook on 11/30/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol reloadTikectsProtocol {
    func reoladData(Data:String)
}
class AddTicketVC: UIViewController {
    
    @IBOutlet weak var lblT: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var lbladsTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var isAds = false
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtMessage: IQTextView!
    
    @IBOutlet weak var lblMsgTitle: UILabel!
    var delegate: reloadTikectsProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isAds {
            self.lbladsTitle.text  = "عنوان الاعلان".localized
            self.lblMsgTitle.text = "تفاصيل الاعلان".localized
            self.lblT.isHidden = true
            self.closeButton.isHidden = true
            self.navigationItem.title = "اضف اعلانك".localized
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendNowTapped(_ sender: Any) {
        
        if txtTitle.text == "" {
            self.errorAlert(title: "تم", body: "الرجاءادخال عنوان الرسالة ")
            return
        }
        
        
        if txtMessage.text == "" {
                 self.errorAlert(title: "تم", body: "الرجاء ادخال نص الرسالة ")
                 return
             }
        
        addTieckt()
    }
    
    func addTieckt(){
        DataClient.addTikcet(title: self.txtTitle.text!, message: self.txtMessage.text!,success: { (dict) in
            if self.isAds {
                self.toastAlert(title: "تم ارسال الاعلان بنجاح")
                self.txtTitle.text = ""
                self.txtMessage.text = "" 
            }else{
                self.delegate.reoladData(Data: "")
                self.dismiss(animated: true, completion: nil)
                self.errorAlert(title: "تم", body: dict)

            }
       
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
