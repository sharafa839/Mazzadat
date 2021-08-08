//
//  CodeAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 11/14/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

protocol MyDataSendingDelegateProtocolAlertt {
    func sendDataToFirstViewController(myData: String,type: String? , code: String? , fromPrice: Int?, toPrice: Int?, endDate: String?, startDate: String)
}

class CodeAlertVC: UIViewController {

    @IBOutlet weak var codeTxt: UITextField!
    var delegate: MyDataSendingDelegateProtocolAlertt?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
        self.delegate?.sendDataToFirstViewController(myData: "", type: "code", code: codeTxt.text ?? "", fromPrice: 0, toPrice: 0, endDate: "", startDate: "")
        dismiss(animated: true, completion: nil)
    }

}
