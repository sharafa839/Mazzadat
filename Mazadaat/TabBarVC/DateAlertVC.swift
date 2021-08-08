//
//  DateAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 11/14/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class DateAlertVC: UIViewController {

     @IBOutlet weak var txtTo: UITextField!
        @IBOutlet weak var txtFrom: UITextField!
        
        var delegate: MyDataSendingDelegateProtocolAlertt?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
        
        @IBAction func searchTapped(_ sender: Any) {
            
            
            if txtTo.text == "" {
                self.delegate?.sendDataToFirstViewController(myData: "", type: "dateFrom", code: "", fromPrice: 0, toPrice: 0, endDate: "", startDate: txtFrom.text ?? "")
            }else if txtFrom.text == "" {
                self.delegate?.sendDataToFirstViewController(myData: "", type: "dateTo", code: "", fromPrice: 0, toPrice: 0, endDate: txtTo.text ?? "", startDate: "")
            }else{
                self.delegate?.sendDataToFirstViewController(myData: "", type: "endDate&StartDate", code: "", fromPrice: 0, toPrice: 0, endDate: txtTo.text ?? "", startDate: "")

            }
            
            
            dismiss(animated: true, completion: nil)

        }
        

    
    @IBAction func toDateTapped(_ sender: Any) {
        RPicker.selectDate(title: "Select Date", didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
                               // TODO: Your implementation for date
                               self?.txtTo.text = selectedDate.toString(format: "yyyy-MM-dd")
                  self?.tabBarController?.tabBar.isHidden = false         })
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func fromTapped(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        
        // Simple Date Picker with title
         RPicker.selectDate(title: "Select Date", didSelectDate: {[weak self] (selectedDate) in
             // TODO: Your implementation for date
                                // TODO: Your implementation for date
                                self?.txtFrom.text = selectedDate.toString(format: "yyyy-MM-dd")
                   self?.tabBarController?.tabBar.isHidden = false         })
         

//        RPicker.selectDate(title: "الى", cancelText: "الغاء", datePickerMode: .date, didSelectDate: { [weak self](selectedDate) in
//                         // TODO: Your implementation for date
//                         self?.txtTo.text = selectedDate.toString(format: "yyyy-MM-dd")
//            self?.tabBarController?.tabBar.isHidden = false
//
//                     })
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
