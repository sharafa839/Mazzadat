//
//  MySubscribeVC.swift
//  Mazadaat
//
//  Created by macbook on 12/15/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MySubscribeVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var mySubscribe: [MySubscribeOB]?
    var userData: userOB?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        getUser()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func dimissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getUser(){
           DataClient.getMyProfile(success: { (dict) in
         
            self.mySubscribe = dict.mySubscribes
            self.tableView.reloadData()
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
}




extension MySubscribeVC:UITabBarDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mySubscribe?.count == 0 {
            return 0

        }else{
            return mySubscribe!.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell") as? mySubCell
        
        let obj = self.mySubscribe?[indexPath.row]
        
        cell?.lblPrice.text = "\(obj?.price ?? "") SAR"
        cell?.pakageTitle.text = obj?.name ?? ""


        
        return cell!
        
    }
    
    
    
    
    
    
    
}



class mySubCell: UITableViewCell{
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var pakageTitle: UILabel!
    
}
