//
//  AuctionsVC.swift
//  Mazadaat
//
//  Created by macbook on 10/20/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SwiftGifOrigin


class AuctionsVC: UIViewController {

    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeHolder: UIImageView!

    @IBOutlet weak var placeHodlerStack: UIStackView!
    var aucationData: [AuctionsOB]=[]
    
    var refreshControl = UIRefreshControl()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppData.isLogin == true {
            
            
            getAuctionData()
             // Do any additional setup after loading the view.
             
             refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
              refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
             
             tableView.addSubview(refreshControl) // not required when using UITableViewController
        }else{
             // Do any additional setup after loading the view.
            placeTitle.text = "يجب التسجيل أولاً".localized
            // not required when using UITableViewController
        }
  
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        
        getAuctionData()

    }
    
    
    func getAuctionData(){
           DataClient.getMyAucations(success: { (dict) in
            self.aucationData = dict

            
            self.aucationData = self.aucationData.filter {
                !($0.code?.contains("noshow"))!
                            }

            self.refreshControl.endRefreshing()

            
            
               self.tableView.reloadData()
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false

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


extension  AuctionsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if aucationData.count == 0 {
                      placeHolder.image = UIImage.gif(name: "371903340_LOCATION_MARKER_400")
                      placeHodlerStack.isHidden = false

                            return 0
                  }else{
            placeHodlerStack.isHidden = true
                      return aucationData.count

                  }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionsCell") as? AuctionsTableViewCell
        
        let obj = aucationData[indexPath.row]
        var mianImg = ""
        
        if let img = obj.mediaArry?.first?.file{
            mianImg = img
        }
        
        cell?.img.sd_setImage(with: mianImg.toURL, completed: nil)
        cell?.auctionsLabel.text = obj.name ?? ""
        
        
        cell?.priceLabel.text = "\( obj.LastBid?.price ?? "") \("ر.س".localized)"

 
        
        if obj.status == 1 {
            setupCountDownLabelTimer(endDate:  obj.end_at ?? "", label:  (cell?.dateLabel)!)

        }else{
            cell?.dateLabel.text = obj.start_at ?? ""

        }
        cell?.aucationNumberLabel.text = "#\(obj.code ?? "")"
        cell?.dateLabel.text = obj.end_at ?? ""
        cell?.auctionsCounterLabel.text = "\(obj.bids_count ?? 0) مزايدة"
        
        return cell!
    }
    
    
    
    
  
    
    
    
    // SetUpCounterLabel
    func setupCountDownLabelTimer(endDate: String,label: UILabel){
        
        
        
        
       
        // Start Timer
        TimerManagerr(interval: 1, endDate: endDate ?? "", stopTimer: false, repeats: true){day, hours, minutes, seconds, hideOfferView  in
            
            //                      if hideOfferView == true {
            //                          return
            //                      }
            
            
            if Int(day) ?? 0 < 0 {
                label.text = endDate ?? ""
                return
            }
            

//                 self.setOfferTimerLalbel(days: day, hours: hours, minutes: minutes, seconds: seconds)
            
            label.text = "\(day)ي \(hours)س \(minutes)د \(seconds)ث "

            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
            },
                           completion: nil)
            
        }.start()
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let obj = aucationData[indexPath.row]
        

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
            vc?.aucationData = obj
        vc?.auctionId = obj.id ?? 0
            self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
    
    
    
    
}
