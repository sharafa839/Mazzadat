//
//  PakagesVC.swift
//  Mazadaat
//
//  Created by macbook on 11/3/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
 import MSPeekCollectionViewDelegateImplementation

class PakagesVC: UIViewController {

    @IBOutlet weak var pgControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var pakaejsData: [SubscribeOB]=[]
    var ind = 0
    var mySubscribe: [MySubscribeOB] = []

    var behavior = MSCollectionViewPeekingBehavior()

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        getCatData()
        title = "باقات التأمين".localized
               collectionView.configureForPeekingBehavior(behavior: behavior)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buyNowTapped(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PakageDetVC") as? PakageDetVC
        
        vc?.pakegeOB = pakaejsData[ind]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getCatData(){
          DataClient.getPakges(success: { (dict) in
            
              self.pakaejsData = dict
            self.pgControl.numberOfPages = dict.count
              self.collectionView.reloadData()
               }, failure: { (err) in
                   
                                  self.errorAlert(title: "Alert", body:  err)
                   
               })

      }
    
    func getUser(){
           DataClient.getMyProfile(success: { (dict) in
         
            self.mySubscribe = dict.mySubscribes
            
            if dict.is_subscribed  == true {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "MySubscribeVC") as? MySubscribeVC
                
                vc?.mySubscribe = dict.mySubscribes
                       vc?.modalTransitionStyle   = .crossDissolve;
                       vc?.modalPresentationStyle = .overCurrentContext
                       vc?.modalPresentationStyle = .overCurrentContext
                self.present(vc!, animated: true, completion: nil)
                
            }
            
     
            
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
    

   
    func snapToCenter() {
        let centerPoint = view.convert(view.center, to: collectionView)
        guard let centerIndexPath = collectionView.indexPathForItem(at: centerPoint) else { return }
        
        collectionView.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
        
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

// MARK: - Scroll view delegate
extension PakagesVC: UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pakaejsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pkjCell", for: indexPath) as? PakgesCell
        
        let obj = pakaejsData[indexPath.row]
        
        cell?.lblTitle.text = obj.name
        cell?.priceLbl.text = "\(obj.price ?? "") ر.س"
        cell?.lblDesc.text = obj.description
        cell?.topImg.roundCorners([.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 12)

        return cell!
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(behavior.currentIndex)
        ind = behavior.currentIndex
        self.pgControl.currentPage = behavior.currentIndex
    }
    
    
    
}

