//
//  TicketsVC.swift
//  Mazadaat
//
//  Created by macbook on 11/30/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class TicketsVC: UIViewController,reloadTikectsProtocol {
    func reoladData(Data: String) {
        getCatData()
        self.toastAlert(title: "تم الحفظ بنجاح")
    }
    

    @IBOutlet weak var tableView: UITableView!
    var tokectData: [TikectOB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NaveBarManager.navgationBar.showNave(vc: self)
        self.title = "التذاكر"
getCatData()
        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }
    
    func getCatData(){
        DataClient.getTickets(success: { (dict) in
          
            self.tokectData = dict
            self.tableView.reloadData()
             }, failure: { (err) in
                 
                                self.errorAlert(title: "Alert", body:  err)
                 
             })

    }

    
    @IBAction func addBtnTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc = storyboard.instantiateViewController(withIdentifier: "AddTicketVC") as? AddTicketVC
          vc?.delegate  = self

                 vc?.modalTransitionStyle   = .crossDissolve;
                 vc?.modalPresentationStyle = .overCurrentContext
                 vc?.modalPresentationStyle = .overCurrentContext
                 present(vc!, animated: true, completion: nil)
    
    }

}


extension TicketsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tokectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tikectCell") as? ticketsCell
        
        let obj = tokectData[indexPath.row]
        
        cell?.lblTitle.text = obj.title ?? ""
        cell?.lblDesc.text = obj.message ?? ""
        if obj.status == 1 {
            cell?.stateView.backgroundColor = UIColor(hex: "47B04B")
            cell?.tikectState.text = "مفتوح"
            
        }else{
            cell?.stateView.backgroundColor = #colorLiteral(red: 0.7096751332, green: 0.1870262921, blue: 0.1327231526, alpha: 1)
                       cell?.tikectState.text = "مغلق"
        }
        
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let obj = tokectData[indexPath.row]
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TicketDetVC") as?         TicketDetVC

            vc?.tikectObj = obj
            self.navigationController?.pushViewController(vc!, animated: true)

        

    }
    
    
    
    
}




class ticketsCell:UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var tikectState: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var img: UIImageView!
    
}
