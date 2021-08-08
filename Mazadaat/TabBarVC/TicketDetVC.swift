//
//  TicketDetVC.swift
//  Mazadaat
//
//  Created by macbook on 12/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class TicketDetVC: UIViewController {

    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var tiekctStateLabel: UILabel!
    @IBOutlet weak var mesageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTxt: UITextField!
    
    @IBOutlet weak var noResponseTitle: UILabel!
    @IBOutlet weak var responseStack: UIStackView!
    var tikectObj: TikectOB?
    var tiketResponse: [TikectResponseOB] = []
    var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
title = "تفاصيل التذكرة"
        tableView.rowHeight = 50
        
        titleLabel.text = tikectObj?.title ?? ""
        mesageLabel.text = tikectObj?.message ?? ""
        
        if tikectObj?.status == 1 {
            stateView.backgroundColor = UIColor(hex: "47B04B")
            tiekctStateLabel.text = "مفتوح"
             
         }else{
             stateView.backgroundColor = #colorLiteral(red: 0.7096751332, green: 0.1870262921, blue: 0.1327231526, alpha: 1)
             tiekctStateLabel.text = "مغلق"
            self.responseStack.isHidden = true
         }
         
        if let responseArry = tikectObj?.tikectArry {
            tiketResponse = responseArry as? Array ?? []
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl) // not required when using UITableViewController

//        tiketResponse = tikectObj?.tikectArry as? Array ?? []
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getCatData()

    }
    
    
    func getCatData(){
        DataClient.showTickets(id: tikectObj?.id ?? 0 ,success: { (dict) in
           
            self.tiketResponse = dict.tikectArry as? Array ?? []
             self.tableView.reloadData()
            self.refreshControl.endRefreshing()

              }, failure: { (err) in
                  
                                 self.errorAlert(title: "Alert", body:  err)
                  
              })

     }

    @IBAction func addResponseTapped(_ sender: Any) {
        
        if inputTxt.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء كتابة الرد")
            return
        }
        
        DataClient.addComment(id: tikectObj?.id ?? 0, comment: inputTxt.text ?? "",success: { (dict) in
            
            
            self.getCatData()
        
          self.tableView.reloadData()
           }, failure: { (err) in
               
                              self.errorAlert(title: "Alert", body:  err)
               
           })

        
    }
    
}


extension TicketDetVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tiketResponse.count != 0 {
            noResponseTitle.isHidden  = true
            return tiketResponse.count

        }else{
            noResponseTitle.isHidden  = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = tiketResponse[indexPath.row]
        
        
        if obj.sender_type == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ticCell") as? ticketsCell
            cell?.img?.sd_setImage(with: AppData.userImg.toURL,placeholderImage:#imageLiteral(resourceName: "user333"), completed: nil)
            cell?.lblTitle.text = obj.response ?? ""

            return cell!

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "adminCell") as? ticketsCell
            cell?.img?.image = #imageLiteral(resourceName: "Group 55047")
            cell?.lblTitle.text = obj.response ?? ""

return cell!
        }

        return UITableViewCell()
    }
    

    
    
    
    
}

