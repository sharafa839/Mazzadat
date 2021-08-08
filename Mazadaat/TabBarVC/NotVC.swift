//
//  NotVC.swift
//  Mazadaat
//
//  Created by macbook on 12/2/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class NotVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var notiData: [NotiOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
title = "الاشعارات"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false

        getNoti()
    }
    
    func getNoti(){
           DataClient.getAllNoti(success: { (dict) in
             
               self.notiData = dict
        
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
    func readNoti(notiId: Int){
           DataClient.readNoti(notiId: notiId,success: { (dict) in
                print("Done")
            self.getNoti()
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })
       }
    
}



extension  NotVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return notiData.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notiCell") as? notiCell
        
        let obj = notiData[indexPath.row]
        cell?.lblDate.text = obj.created_at ?? ""
        cell?.titleLbl.text = obj.title ?? ""
        cell?.descLbl.text = obj.message ?? ""
        
        if obj.read_at == "" {
            cell?.readView.isHidden = false
        }else{
            cell?.readView.isHidden = true

        }
        return cell!
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let obj = notiData[indexPath.row]
        
        switch obj.type {
        case 1:
            print("General")
            
            
            self.readNoti(notiId: obj.id ?? 0)

            return
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
            
            vc?.auctionId = obj.ref_id ?? 0
            vc?.notiId = obj.id ?? 0
            vc?.isNoti = true
                   self.navigationController?.pushViewController(vc!, animated: true)

        case 2:
            print("Auction")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
            vc?.isNoti = true
            vc?.notiId = obj.id ?? 0


                      vc?.auctionId = obj.ref_id ?? 0
                             self.navigationController?.pushViewController(vc!, animated: true)

        case 3:
            print("Ticket")
            self.readNoti(notiId: obj.id ?? 0)
            getNoti()

        case 4:
            print("Chat")
            self.readNoti(notiId: obj.id ?? 0)
            getNoti()


                case 5:
                    self.readNoti(notiId: obj.id ?? 0)
                    getNoti()


                    print("            xgSubscription")

        default:
            break
        }

   
    }
    
 
    
}



class notiCell:UITableViewCell{
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var readView: DesignableView!
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
}
