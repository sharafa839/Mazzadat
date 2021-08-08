//
//  FaveVC.swift
//  Mazadaat
//
//  Created by macbook on 11/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class FaveVC: UIViewController,MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: String) {
        getAuctionData()
    }
    
  
    @IBOutlet weak var placeHolder: UIImageView!
    @IBOutlet weak var tableView: UITableView!

        var aucationData: [AuctionsOB]=[]
        
    var refreshControl = UIRefreshControl()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationItem.title = "متابعاتي"
            
            if AppData.isLogin == false {
                
                return
            }
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
             refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            
            tableView.addSubview(refreshControl) // not required when using UITableViewController
            // Do any additional setup after loading the view.
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false

        if AppData.isLogin == true {
            getAuctionData()

        }else{
            self.toastAlert(title: "الرجاء تسجيل الدخول")

        }

    }
    
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        
        
        if AppData.isLogin == true {
            getAuctionData()

        }
       

    }
    
        
        
        func getAuctionData(){
               DataClient.getMyFave(success: { (dict) in
                 
                   self.aucationData = dict
                
                self.aucationData = dict.filter {
                    $0.is_favourite == true
                }
            
                   self.tableView.reloadData()
                self.refreshControl.endRefreshing()

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


    extension  FaveVC:UITableViewDelegate,UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if aucationData.count == 0 {
                placeHolder.image = UIImage.gif(name: "fave")
                placeHolder.isHidden = false

                      return 0
            }else{
                placeHolder.isHidden = true
                return aucationData.count

            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaveCell") as? AuctionsTableViewCell
            
            let obj = aucationData[indexPath.row]
            var mianImg = ""
            
            if let img = obj.mediaArry?.first?.file{
                mianImg = img
            }
            
            cell?.img.sd_setImage(with: mianImg.toURL, completed: nil)
            cell?.auctionsLabel.text = obj.name ?? ""
            cell?.priceLabel.text = obj.price ?? ""
            cell?.aucationNumberLabel.text = "#\(obj.code ?? "")"
            cell?.dateLabel.text = obj.start_at ?? ""
            cell?.heartBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
            cell?.heartBtn.tag = indexPath.row

            return cell!
        }
        
        @objc func connected(sender: UIButton){
            let buttonTag = sender.tag
            let obj  = self.aucationData[buttonTag]
            addLike(id: obj.id ?? 0)

            
        }
        
        
        

        func addLike(id:Int){
            
            DataClient.addFave(auctionId:id,success: { (dict) in
            
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
                           vc?.modalTransitionStyle   = .crossDissolve;
                                 vc?.modalPresentationStyle = .overCurrentContext
                                 vc?.modalPresentationStyle = .overCurrentContext
                           vc?.titleDec = "هل تريد حقاً الغاء متابعة هذا المزاد؟"
                           vc?.titleStr = "الغاء متابعة"
            
                vc?.delegate = self
                           vc?.ConfirmBtnStr = "الغاء المتابعة"
                                 self.present(vc!, animated: true, completion: nil)
                
                
                
                  }, failure: { (err) in
                      
                                     self.errorAlert(title: "Alert", body:  err)
                      
                  })

         }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    let obj = aucationData[indexPath.row]
            

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
            vc?.auctionId = obj.id
                self.navigationController?.pushViewController(vc!, animated: true)

        }
        
        
        
        
        
        
    }

