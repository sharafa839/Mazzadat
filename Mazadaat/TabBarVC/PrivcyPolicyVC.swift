//
//  PrivcyPolicyVC.swift
//  Mazadaat
//
//  Created by macbook on 12/9/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class PrivcyPolicyVC: UIViewController {

    @IBOutlet weak var lblDesc: UITextView!
    
    @IBOutlet weak var lbltitle: UILabel!
    var policyData: settingOB?
    
    var isTerm = false
    override func viewDidLoad() {
        super.viewDidLoad()

        getCatData()
        // Do any additional setup after loading the view.
    }
    
    func getCatData(){
         DataClient.getPolicy(success: { (dict) in
           
            if self.isTerm{
                self.title = "شروط الاستخدام"
                self.lblDesc.attributedText = dict.terms?.htmlToAttributedString
                }else{

                self.title = "سياسة الخصوصية"
                    self.lblDesc.attributedText = dict.privacy?.htmlToAttributedString

//                self.lblDesc.text = dict.privacy ?? ""
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




extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
