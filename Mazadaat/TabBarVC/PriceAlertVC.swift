//
//  PriceAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 11/14/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class PriceAlertVC: UIViewController {

    @IBOutlet weak var txtTo: UITextField!
    @IBOutlet weak var txtFrom: UITextField!
    
    var delegate: MyDataSendingDelegateProtocolAlertt?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
        if txtTo.text == "" {
            self.delegate?.sendDataToFirstViewController(myData: "", type: "priceFrom", code: "", fromPrice: Int(txtFrom.text ?? ""), toPrice: 0, endDate: "", startDate:  "")
        }else if txtFrom.text == "" {
            self.delegate?.sendDataToFirstViewController(myData: "", type: "priceTo", code: "", fromPrice: 0, toPrice: 0, endDate: txtTo.text ?? "", startDate: "")
        }else{
            self.delegate?.sendDataToFirstViewController(myData: "", type: "priceFrom&To", code: "", fromPrice:Int(txtFrom.text ?? ""), toPrice: Int(txtTo.text ?? ""), endDate: txtTo.text ?? "", startDate: "")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissVc(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
