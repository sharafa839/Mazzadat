//
//  CatDetVC.swift
//  Mazadaat
//
//  Created by macbook on 11/13/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class CatDetVC: UIViewController,MyDataSendingDelegateProtocolAlertt, MyDataSendingDelegateProtocol{
    @IBOutlet weak var lblDet: UILabel!
    func sendDataToFirstViewController(myData: String, type: String?, code: String?, fromPrice: Int?, toPrice: Int?, endDate: String?, startDate: String) {
        
        self.tabBarController?.tabBar.isHidden = false

        
        self.aucationData.removeAll()
         switch type {
               case "code":
                self.getAuctionData(type: "code", code: code ?? "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate ?? "" , EndDate: endDate ?? "")
                
                   codeCiew.topColor = UIColor(hexString: "FFA418")
                   codeCiew.bottomColor = UIColor(hexString: "F5B200")
                   
                   auctionView.topColor = UIColor.white
                   auctionView.bottomColor = UIColor.white
                   
                   
                   dateView.topColor = UIColor.white
                   dateView.bottomColor = UIColor.white
                   
                   priceView.topColor = UIColor.white
                   priceView.bottomColor = UIColor.white
                   
                   auctionBtn.setTitleColor(UIColor.black, for: .normal)
                priceBtn.setTitleColor(UIColor.black, for: .normal)
                   dateBtn.setTitleColor(UIColor.black, for: .normal)
                   codeBtn.setTitleColor(UIColor.white, for: .normal)

                              
               case "priceTo":
                   
                self.getAuctionData(type: "priceTo", code: "", priceTo: fromPrice ?? 0, priceFrom: toPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                          self.tableView.reloadData()
                   
                   priceView.topColor = UIColor(hexString: "F5B200")
                        priceView.bottomColor = UIColor(hexString: "FFA418")
                        
                        auctionView.topColor = UIColor.white
                        auctionView.bottomColor = UIColor.white
                        
                        
                        dateView.topColor = UIColor.white
                        dateView.bottomColor = UIColor.white
                        
                        codeCiew.topColor = UIColor.white
                        codeCiew.bottomColor = UIColor.white
                   
                   auctionBtn.setTitleColor(UIColor.black, for: .normal)
                    codeBtn.setTitleColor(UIColor.black, for: .normal)
                       dateBtn.setTitleColor(UIColor.black, for: .normal)
                       priceBtn.setTitleColor(UIColor.white, for: .normal)
            
            
            case "priceFrom":
               
                self.getAuctionData(type: "priceFrom", code: "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                      self.tableView.reloadData()
               
               priceView.topColor = UIColor(hexString: "F5B200")
                    priceView.bottomColor = UIColor(hexString: "FFA418")
                    
                    auctionView.topColor = UIColor.white
                    auctionView.bottomColor = UIColor.white
                    
                    
                    dateView.topColor = UIColor.white
                    dateView.bottomColor = UIColor.white
                    
                    codeCiew.topColor = UIColor.white
                    codeCiew.bottomColor = UIColor.white
               
               auctionBtn.setTitleColor(UIColor.black, for: .normal)
                codeBtn.setTitleColor(UIColor.black, for: .normal)
                   dateBtn.setTitleColor(UIColor.black, for: .normal)
                   priceBtn.setTitleColor(UIColor.white, for: .normal)

            
            case "priceFrom&To":
                          
                self.getAuctionData(type: "priceFrom&To", code: "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                                 self.tableView.reloadData()
                          
                          priceView.topColor = UIColor(hexString: "F5B200")
                               priceView.bottomColor = UIColor(hexString: "FFA418")
                               
                               auctionView.topColor = UIColor.white
                               auctionView.bottomColor = UIColor.white
                               
                               
                               dateView.topColor = UIColor.white
                               dateView.bottomColor = UIColor.white
                               
                               codeCiew.topColor = UIColor.white
                               codeCiew.bottomColor = UIColor.white
                          
                          auctionBtn.setTitleColor(UIColor.black, for: .normal)
                           codeBtn.setTitleColor(UIColor.black, for: .normal)
                              dateBtn.setTitleColor(UIColor.black, for: .normal)
                              priceBtn.setTitleColor(UIColor.white, for: .normal)
                     
               case "dateTo":
                   
                self.getAuctionData(type: "dateTo", code: "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                          self.tableView.reloadData()
                   
                   dateView.topColor = UIColor(hexString: "F5B200")
                                 dateView.bottomColor = UIColor(hexString: "FFA418")
                                 
                                 auctionView.topColor = UIColor.white
                                 auctionView.bottomColor = UIColor.white
                                 
                                 
                                 priceView.topColor = UIColor.white
                                 priceView.bottomColor = UIColor.white
                                 
                                 codeCiew.topColor = UIColor.white
                                 codeCiew.bottomColor = UIColor.white
                   
                   
                   auctionBtn.setTitleColor(UIColor.black, for: .normal)
                          codeBtn.setTitleColor(UIColor.black, for: .normal)
                             priceBtn.setTitleColor(UIColor.black, for: .normal)
                             dateBtn.setTitleColor(UIColor.white, for: .normal)

            
            case "dateFrom":
                            
                         self.getAuctionData(type: "dateFrom", code: "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                                   self.tableView.reloadData()
                            
                            dateView.topColor = UIColor(hexString: "F5B200")
                                          dateView.bottomColor = UIColor(hexString: "FFA418")
                                          
                                          auctionView.topColor = UIColor.white
                                          auctionView.bottomColor = UIColor.white
                                          
                                          
                                          priceView.topColor = UIColor.white
                                          priceView.bottomColor = UIColor.white
                                          
                                          codeCiew.topColor = UIColor.white
                                          codeCiew.bottomColor = UIColor.white
                            
                            
                            auctionBtn.setTitleColor(UIColor.black, for: .normal)
                                   codeBtn.setTitleColor(UIColor.black, for: .normal)
                                      priceBtn.setTitleColor(UIColor.black, for: .normal)
                                      dateBtn.setTitleColor(UIColor.white, for: .normal)
            

            
            case "endDate&StartDate":
                            
                         self.getAuctionData(type: "endDate&StartDate", code: "", priceTo: toPrice ?? 0, priceFrom: fromPrice ?? 0, startDate: startDate, EndDate: endDate ?? "")

                                   self.tableView.reloadData()
                            
                            dateView.topColor = UIColor(hexString: "F5B200")
                                          dateView.bottomColor = UIColor(hexString: "FFA418")
                                          
                                          auctionView.topColor = UIColor.white
                                          auctionView.bottomColor = UIColor.white
                                          
                                          
                                          priceView.topColor = UIColor.white
                                          priceView.bottomColor = UIColor.white
                                          
                                          codeCiew.topColor = UIColor.white
                                          codeCiew.bottomColor = UIColor.white
                            
                            
                            auctionBtn.setTitleColor(UIColor.black, for: .normal)
                                   codeBtn.setTitleColor(UIColor.black, for: .normal)
                                      priceBtn.setTitleColor(UIColor.black, for: .normal)
                                      dateBtn.setTitleColor(UIColor.white, for: .normal)
                   

               default:
                   break
               }
    }
    
    
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var auctionBtn: UIButton!
    @IBOutlet weak var auctionView: DesignableView!
    @IBOutlet weak var dateView: DesignableView!
    @IBOutlet weak var priceView: DesignableView!
    @IBOutlet weak var codeCiew: DesignableView!

    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var placeHolderImg: UIImageView!
    
    
    
   
    func sendDataToFirstViewController(myData: String) {
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0 ,startDate: "",EndDate: "")
    }
    
    

    
    var aucationData: [AuctionsOB]=[]
    var catId = 0
    var refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name("reloadTimer"), object: nil)

        // not required when using UITableViewController
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table vie
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")

        refreshControl.endRefreshing()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.tabBarController?.tabBar.isHidden = false

        
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")

        
        
        

        
        

       }
       
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")
        


    }
    
    
    func getAuctionData(type:String, code: String, priceTo: Int, priceFrom: Int,startDate: String, EndDate: String){
        
        DataClient.getMyAucationsFilter(catId:catId,filterType: type, code: code, startDate: startDate, EndDate: EndDate, priceFrom: priceFrom, priceTo: priceTo,success: { (dict) in
            
            
            
//
//             // Start Timer
//             TimerManagerr(interval: 1, endDate: "", stopTimer: false, repeats: true){day, hours, minutes, seconds, hideOfferView  in
//
//
//
//                 UIView.animate(withDuration: 1.0,
//                                delay: 0.0,
//                                usingSpringWithDamping: 0.9,
//                                initialSpringVelocity: 1,
//                                options: [],
//                                animations: {
//                 },
//                                completion: nil)
//
//             }.start()
//

            self.aucationData = dict
            self.aucationData = self.aucationData.filter {
                $0.category_id == self.catId
            }
            
            self.aucationData = self.aucationData.filter {
                !($0.code?.contains("noshow"))!
                            }
            self.tableView.reloadData()
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    @IBAction func aucationTapped(_ sender: Any) {
        getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")
        
        
        
                          auctionView.topColor = UIColor(hexString: "FFA418")
                          auctionView.bottomColor = UIColor(hexString: "F5B200")
                          
                          codeCiew.topColor = UIColor.white
                          codeCiew.bottomColor = UIColor.white
                          
                          
                          dateView.topColor = UIColor.white
                          dateView.bottomColor = UIColor.white
                          
                          priceView.topColor = UIColor.white
                          priceView.bottomColor = UIColor.white
                          
                          auctionBtn.setTitleColor(UIColor.white, for: .normal)
                       priceBtn.setTitleColor(UIColor.black, for: .normal)
                          dateBtn.setTitleColor(UIColor.black, for: .normal)
                          codeBtn.setTitleColor(UIColor.black, for: .normal)


    }
    
    @IBAction func codeSearchTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "CodeAlertVC") as? CodeAlertVC
                  vc?.modalTransitionStyle   = .crossDissolve;
                  vc?.modalPresentationStyle = .overCurrentContext
                  vc?.modalPresentationStyle = .overCurrentContext
                  vc?.delegate = self
                  present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func priceSerachTapped(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "PriceAlertVC") as? PriceAlertVC
                  vc?.modalTransitionStyle   = .crossDissolve;
                  vc?.modalPresentationStyle = .overCurrentContext
                  vc?.modalPresentationStyle = .overCurrentContext
        vc?.delegate = self

                  present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func endDateSearchTapped(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "DateAlertVC") as? DateAlertVC
                  vc?.modalTransitionStyle   = .crossDissolve;
                  vc?.modalPresentationStyle = .overCurrentContext
                  vc?.modalPresentationStyle = .overCurrentContext
        vc?.delegate = self
//        self.tabBarController?.tabBar.isHidden = true

                  present(vc!, animated: true, completion: nil)
    }
    
    
}

extension  CatDetVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if aucationData.count == 0 {
            placeHolderImg.image = UIImage.gif(name: "371903340_LOCATION_MARKER_400")
            lblPlaceHolder.isHidden = false
            placeHolderImg.isHidden = false
            lblDet.isHidden = false

        }else{
            
                lblPlaceHolder.isHidden = true
                placeHolderImg.isHidden = true
            lblDet.isHidden = true
            return aucationData.count
            
        }
        return aucationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell") as? AuctionsTableViewCell
        
        
       let obj = aucationData[indexPath.row]
                var mianImg = ""
                
                if let img = obj.mediaArry?.first?.file{
                    mianImg = img
                }
        
        
        cell?.auctionNumber.text =  "\(obj.bids_count ?? 0) مزايدة"
                
                cell?.img.sd_setImage(with: mianImg.toURL, completed: nil)
                cell?.auctionsLabel.text = obj.name ?? ""
        
        
        if obj.LastBid?.price != nil ||  obj.LastBid?.price != ""{
            cell?.priceLabel.text = "\(obj.LastBid?.price  ?? obj.price ?? "") \("ر.س".localized)"

        }else{
            cell?.priceLabel.text = "\(obj.price ?? "") \("ر.س".localized)"
        }
        
        if obj.status == 1 {
//            setupCountDownLabelTimer(endDate:  obj.end_at ?? "", label:  (cell?.dateLabel)!)
            cell?.startTimer(endDate: obj.end_at ?? "")
        }else{
            cell?.dateLabel.text = obj.start_at ?? ""

        }
                cell?.aucationNumberLabel.text = "#\(obj.code ?? "")"
        
                cell?.heartBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
                cell?.heartBtn.tag = indexPath.row
        
        
        if obj.is_favourite == true {
    
            cell?.heartBtn.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            cell?.auctionsCounterLabel.textColor = #colorLiteral(red: 1, green: 0.7617025375, blue: 0, alpha: 1)
        }else{
            cell?.heartBtn.setImage(#imageLiteral(resourceName: "Group 550577"), for: .normal)
            cell?.auctionsCounterLabel.textColor = #colorLiteral(red: 0.7571704984, green: 0.7455955148, blue: 0.716252625, alpha: 1)


        }
        return cell!
    }
    
    @objc func connected(sender: UIButton){
           let buttonTag = sender.tag
           let obj  = self.aucationData[buttonTag]
        
        if obj.is_favourite == true {
            addLike(id: obj.id ?? 0,isFave: true )

        }else{
            addLike(id: obj.id ?? 0,isFave: false)

        }

           
       }
    
    
  
    
    // SetUpCounterLabel
    func setupCountDownLabelTimer(endDate: String,label: UILabel){
        
        
        
        
       
        // Start Timer
        TimerManagerr(interval: 1, endDate: endDate ?? "", stopTimer: false, repeats: true){day, hours, minutes, seconds, hideOfferView  in
    
            if Int(day) ?? 0 < 0 {
                label.text = endDate ?? ""
                return
            }
            

                 self.setOfferTimerLalbel(days: day, hours: hours, minutes: minutes, seconds: seconds)
            
          
                label.text = "\(day)ي \(hours)س \(minutes)د \(seconds)ث "
print("Timer",label.text)

          
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
    
    func setOfferTimerLalbel(days: String, hours: String, minutes: String, seconds: String){
    }
    
    func addLike(id:Int,isFave: Bool){
              
              DataClient.addFave(auctionId:id,success: { (dict) in
      
                
                self.getAuctionData(type: "none", code: "", priceTo: 0, priceFrom: 0, startDate: "", EndDate: "")
                    }, failure: { (err) in
                        
                                       self.errorAlert(title: "Alert", body:  err)
                        
                    })

           }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = aucationData[indexPath.row]
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
        vc?.aucationData = obj
        vc?.auctionId  = obj.id
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
  
    
    
    
    
    
    
}
