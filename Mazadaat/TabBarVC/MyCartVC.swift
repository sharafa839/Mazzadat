//
//  MyCartVC.swift
//  Mazadaat
//
//  Created by macbook on 12/1/20.
//  Copyright © 2020 macbook. All rights reserved.


import UIKit

class MyCartVC: UIViewController {

    
    @IBOutlet weak var placeHolder: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var cartAucationDatat: [AuctionsOB] = []
    var lastPg:Int=1
    var cuurentPg = 1
    var limit:Int=0
    var offset:Int=0 //pageNo
    var isLoading = false
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppData.isLogin == false {
            
            return
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if AppData.isLogin == false {
            self.toastAlert(title: "الرجاء تسجيل الدخول")
            return
        }
        cartAucationDatat.removeAll()

        getAuctionData(pg: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if AppData.isLogin == false {
            self.toastAlert(title: "الرجاء تسجيل الدخول")
            return
        }
        self.tabBarController?.tabBar.isHidden = false

        cuurentPg = 1
        cartAucationDatat.removeAll()
        getAuctionData(pg: 1)
    }
    
    func getAuctionData(pg:Int){
        DataClient.getMyCartAucation(page:pg,success: { (dict, totalPages) in
             
            
            self.cartAucationDatat.append(contentsOf: dict)
        
            self.lastPg = totalPages
               self.tableView.reloadData()
            self.refreshControl.endRefreshing()

                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })
       }
  
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let isReachingEnd = scrollView.contentOffset.y >= 0
          && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        
        if AppData.isLogin == false {
            self.toastAlert(title: "الرجاء تسجيل الدخول")
            return
        }
        if cuurentPg <= lastPg {
            cuurentPg += 1
            self.getAuctionData(pg: cuurentPg)
        }
        
    }
}


extension  MyCartVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cartAucationDatat.count == 0 {
            placeHolder.image = UIImage.gif(name: "animation_500_ki6jfbzh")
            placeHolder.isHidden = false

            
                  return 0
        }else{
            
            placeHolder.isHidden = true

            return cartAucationDatat.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell") as? MyCartCell
        
        let obj = cartAucationDatat[indexPath.row]
        var mianImg = ""
        
        if let img = obj.mediaArry?.first?.file{
            mianImg = img
        }
        
        cell?.img.sd_setImage(with: mianImg.toURL, completed: nil)
        cell?.lblTitle.text = obj.name ?? ""
        cell?.lblDesc.text = "\(obj.LastBid?.price ?? "") \("ر.س".localized)"
        cell?.lblCode.text = "#\(obj.code ?? "")"
        cell?.lblDate.text = obj.start_at ?? ""

        
        if obj.status == 3 {
            cell?.botomView.backgroundColor = #colorLiteral(red: 0.6175402403, green: 0.108195059, blue: 0.6995844841, alpha: 1)
            cell?.stateTitle.text = "في انتظار دفع العميل".localized
        }else if  obj.status == 4{
        
        cell?.botomView.backgroundColor = #colorLiteral(red: 0, green: 0.5545576811, blue: 0.01565600745, alpha: 1)
                   cell?.stateTitle.text = "تهانينا, أنت الفائز".localized
        }else if  obj.status == 6{
            cell?.botomView.backgroundColor = #colorLiteral(red: 0.9672424197, green: 0.2554436922, blue: 0.175907135, alpha: 1)
        cell?.stateTitle.text = "تم الغاء العميل".localized
    }else if  obj.status == 5 {
        cell?.botomView.backgroundColor = #colorLiteral(red: 0.9672424197, green: 0.2554436922, blue: 0.175907135, alpha: 1)
        cell?.stateTitle.text = "ملغي من قبل المورد".localized

    }else {
            cell?.botomView.backgroundColor = #colorLiteral(red: 0.2417990267, green: 0.3042567968, blue: 0.7206580043, alpha: 1)
            cell?.stateTitle.text = "في انتظار موافقة المورد".localized

        }
        return cell!
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let obj = cartAucationDatat[indexPath.row]
        

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
        vc?.auctionId = obj.id
            self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
    
    
    
    
}

