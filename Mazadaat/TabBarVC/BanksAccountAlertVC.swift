//
//  BanksAccountAlertVC.swift
//  Mazadaat
//
//  Created by macbook on 11/30/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class BanksAccountAlertVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var bankData: [banksOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       getCatData()
        // Do any additional setup after loading the view.
    }
    
    
    func getCatData(){
           DataClient.getBanks(success: { (dict) in
            self.bankData = dict

            self.tableView.reloadData()
            
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



extension BanksAccountAlertVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankCell") as? banckAccountsCell
        
        let obj = bankData[indexPath.row]
        cell?.lblname.text = obj.account_name
        cell?.accountNumber.text = obj.account_number ?? ""
        cell?.anotherNumber.text = obj.account_iban ?? ""
        
        
        cell?.okBtn.addTarget(self, action: #selector(dimiss(sender:)), for: .touchUpInside)
        cell?.okBtn.tag = indexPath.row
        
        cell?.copyButton.addTarget(self, action: #selector(copyAccountNumber(sender:)), for: .touchUpInside)
        cell?.copyButton.tag = indexPath.row
        
        
        cell?.copyIban.addTarget(self, action: #selector(copyIbanNumber(sender:)), for: .touchUpInside)
        cell?.copyIban.tag = indexPath.row
        return cell!

    }
    
    
    @objc func dimiss(sender: UIButton){
        let buttonTag = sender.tag
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func copyAccountNumber(sender: UIButton){
        let buttonTag = sender.tag
        
        let obj = bankData[buttonTag]
        UIPasteboard.general.string = obj.account_number // or use  sender.titleLabel.text
        
        toastAlert(title: "تم النسخ")

        
    }
    
    
    
    @objc func copyIbanNumber(sender: UIButton){
        let buttonTag = sender.tag
        
        
        let obj = bankData[buttonTag]
        UIPasteboard.general.string = obj.account_iban// or use  sender.titleLabel.text
        
        toastAlert(title: "تم النسخ")

    }
}



class banckAccountsCell: UITableViewCell{
    
    
    @IBOutlet weak var copyIban: UIButton!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var anotherNumber: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    
}
