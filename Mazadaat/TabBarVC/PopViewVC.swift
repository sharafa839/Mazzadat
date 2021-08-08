//
//  PopViewVC.swift
//  Mazadaat
//
//  Created by macbook on 10/31/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit


protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: String)
}

protocol ProtoctolGoTOPakages {
    func goToPakegs(reload: Bool)
}


protocol MyDataSendingDelegateProtocolAuction {
    func sendDataToFirstViewControllerAuction(myData: AuctionsOB)
}
class PopViewVC: UIViewController ,getRolePageProtocol{

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var chekBoxBtn: UIButton!
    
    @IBOutlet weak var policyLabelTapped: UILabel!
    @IBOutlet weak var highPriceStack: UIStackView!
    
    var delegatePak: ProtoctolGoTOPakages?
    var delegate: MyDataSendingDelegateProtocolAuction? = nil
    var aucationData: AuctionsOB?
    var priceCounter : Double?
    var total : Double = 0.0
    var totalFix : Int = 0
var auctionId = 0
    var miniBid : Double = 0.0
    var plusValue : Double = 0.0

    var fixedPrice : Double = 0.0

    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        self.chekBoxBtn.setImage(#imageLiteral(resourceName: "empty"), for: .normal)
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopViewVC.tapFunction))
        policyLabelTapped.isUserInteractionEnabled = true
        policyLabelTapped.addGestureRecognizer(tap)
               
               
        if aucationData?.LastBid?.user_id == AppData.userId {
                   self.highPriceStack.isHidden = false
               }else{
                   self.highPriceStack.isHidden = true

               }
               self.plusValue = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0

                        
                        if self.aucationData?.LastBid?.price == "" || self.aucationData?.LastBid?.price == nil {
                           self.miniBid = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0
                           self.fixedPrice = Double(self.aucationData?.price  ?? "") ?? 0.0

                           self.total = self.miniBid+self.fixedPrice
                           self.totalFix = Int(self.miniBid+self.fixedPrice)
                                    }else{
                            
                           self.miniBid = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0
                           self.fixedPrice = Double(self.aucationData?.LastBid?.price  ?? "") ?? 0.0
                           self.total = self.miniBid+self.fixedPrice
                           self.totalFix = Int(self.miniBid+self.fixedPrice)
                                    }
                    
                  

               self.lblPrice.text = "\(self.total) ر.س"
//        self.getAuctionData()

        // Do any additional setup after loading the view.
    }
    
    
    @objc
        func tapFunction(sender:UITapGestureRecognizer) {
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let vc = storyboard.instantiateViewController(withIdentifier: "AuctionRolesVC") as?  AuctionRolesVC
                      vc?.auctionData   = aucationData
            vc?.delegate = self
            vc?.isPop = true
                      self.present(vc!, animated: true, completion: nil)
            
//            let story = UIStoryboard(name: "Main", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC")
//
//            self.present(vc, animated: true, completion: nil)
////            self.navigationController?.pushViewController(vc, animated: true)
//            print("tap working")
        }
    
    func gotoRolesPAge(myData: String) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
        vc?.isTerm = true
//        self.present(vc, animated: true, completion: nil)
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    func addBidFiresTore(){
        ActivityIndicatorManager.start()
        
        DataClient.addBidInFireStore(bidId:aucationData?.LastBid?.id ?? 0,auctionId: auctionId,price: total,success: { (dict) in
            ActivityIndicatorManager.stop()
            self.delegate?.sendDataToFirstViewControllerAuction(myData: self.aucationData!)

               self.dismiss(animated: true, completion: nil)

                    }, failure: { (err) in
                        
                    self.errorAlert(title: "Alert", body:  err)
                        
                    })
    }
    
    func getAuctionData(){
           DataClient.getSingleAucations(auctionId: aucationData?.id ?? 0,success: { (dict) in

            self.aucationData = dict
           
            
            
            if dict.LastBid?.user_id == AppData.userId {
                self.highPriceStack.isHidden = false
            }else{
                self.highPriceStack.isHidden = true

            }
            self.plusValue = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0

                     
                     if self.aucationData?.LastBid?.price == "" || self.aucationData?.LastBid?.price == nil {
                        self.miniBid = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0
                        self.fixedPrice = Double(self.aucationData?.price  ?? "") ?? 0.0

                        self.total = self.miniBid+self.fixedPrice
                        self.totalFix = Int(self.miniBid+self.fixedPrice)
                                 }else{
                         
                        self.miniBid = Double(self.aucationData?.minimum_bid  ?? "") ?? 0.0
                        self.fixedPrice = Double(self.aucationData?.LastBid?.price  ?? "") ?? 0.0
                        self.total = self.miniBid+self.fixedPrice
                        self.totalFix = Int(self.miniBid+self.fixedPrice)
                                 }
                 
               

            self.lblPrice.text = "\(self.total) ر.س"
                   }, failure: { (err) in
                       
                   self.errorAlert(title: "Alert", body:  err)
                       
                   })

          }
       
    @IBAction func plusTapped(_ sender: Any) {
        
        if counter == 0  || counter > 0 {
       
            total += plusValue
            lblPrice.text = "\(total) ر.س"
        }
    }
    
    
    func addBid(){
     DataClient.addBid(auctionId: auctionId,price: total,success: { (dict) in
        self.aucationData = dict
        self.addBidFiresTore()
             }, failure: { (err) in
                 
//             self.errorAlert(title: "Alert", body:  err)
                
                // Create the alert controller
                let alertController = UIAlertController(title: "Alert".localized, message: err, preferredStyle: .alert)

                // Create the actions
                let okAction = UIAlertAction(title: "الباقات", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.delegatePak?.goToPakegs(reload: true)
                    self.dismiss(animated: true, completion: nil)



                }
                let cancelAction = UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }

                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
                 
             })

    }
    
    @IBAction func auctionTapped(_ sender: Any) {
        if chekBoxBtn.currentImage == #imageLiteral(resourceName: "Group 5"){
            addBid()
        }else{
            self.errorAlert(title: "تنبيه", body: "الرجاء الموافقة على السياسة والخصوصية")
        }
    }
    
    @IBAction func chekBoxTapped(_ sender: Any) {
        
        if chekBoxBtn.currentImage == #imageLiteral(resourceName: "empty"){
            chekBoxBtn.setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
        }else{
            chekBoxBtn.setImage(#imageLiteral(resourceName: "empty"), for: .normal)
        }
    }
    
    @IBAction func dimissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func minuesTapped(_ sender: Any) {
        
        if Int(total) > totalFix {
            total -= Double(plusValue)

            lblPrice.text = "\(total)ر.س "

               }
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
