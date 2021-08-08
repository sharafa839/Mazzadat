//
//  HomeVC.swift
//  Mazadaat
//
//  Created by macbook on 10/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

class HomeVC: UIViewController {

    @IBOutlet weak var sliderView: ImageSlideshow!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHigh: NSLayoutConstraint!
    @IBOutlet weak var scrollV: UIScrollView!
    
    var catData: [CategoryOB]=[]
    var notiData: [NotiOB] = []
    var refreshControl = UIRefreshControl()

    let catIcons = [#imageLiteral(resourceName: "hotel"),#imageLiteral(resourceName: "palette"),#imageLiteral(resourceName: "smartphone"),#imageLiteral(resourceName: "airplane"),#imageLiteral(resourceName: "number"),#imageLiteral(resourceName: "hotel"),#imageLiteral(resourceName: "piano"),#imageLiteral(resourceName: "hotel (1)"),#imageLiteral(resourceName: "Page-1"),#imageLiteral(resourceName: "tshirt")]
    let iconTitle = ["بيوت","لوحات رسم","جوالات","طيارات","لوحة سيارة","الات موسيقية","أثاث منزلي","مجوهرات","ملابس"]
    private let spacing:CGFloat = 16.0
    var aucationData: [AuctionsOB]=[]

    var sliderImg :[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
   
        title = "الرئيسية".localized
        
        
         setupCollection()
        getInstall()
        sliderView.roundCorners([.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 10)
        
        if AppData.isLogin == true {
            getNoti()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
             refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            
            scrollV.addSubview(refreshControl) // not required when using UITableViewController
        }else{
            
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
             refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            
            scrollV.addSubview(refreshControl) // not required when using UITableViewController
        }
     
    }
    
    func getCatData(){
         DataClient.getPolicy(success: { (dict) in
           
            AppData.showPayment = dict.in_app_purchase_apple ?? "0"
              }, failure: { (err) in
                  
                                 self.errorAlert(title: "Alert", body:  err)
                  
              })

     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if AppData.isLogin == true{
            
            getCatData()
                getAuctionData()
            getNoti()
        }else{
            
            getCatData()
                getAuctionData()
        }
      
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if AppData.isLogin == true{
            
            getCatData()
            getAuctionData()
            getNoti()
        }else{
            getCatData()
            getAuctionData()
        }
       
        refreshControl.endRefreshing()

    }
    
    
    func getNoti(){
            DataClient.getAllNoti(success: { (dict) in
              
                
                self.notiData = dict
                let btn = BadgedButtonItem(with: #imageLiteral(resourceName: "bell").withTintColor(.white))
                          self.navigationItem.rightBarButtonItem = btn
                          
                          btn.tapAction = {
                              // do something
                          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotVC")
                                     self.navigationController?.pushViewController(vc, animated: true)
                                  
                              }
                let filterNoti =  self.notiData.filter{ $0.read_at == ""}

                btn.setBadge(with: Int(filterNoti.count))

                 }, failure: { (err) in
                     
//                 self.errorAlert(title: "Alert", body:  err)
                     
                 })

        }
    
    @IBAction func notiTapped(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "NotVC", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
    }
    
    @IBAction func sideMenu(_ sender: Any) {
           RouteManager.showSideMenuVC(self)
       }
    
    
    func setUpSLider(){
        var sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")]
           
           
           sdWebImageSource.removeAll()
//           for i in imagArr{
//               sdWebImageSource.append(SDWebImageSource(urlString: i)!)
//
//           }
           
           sliderView.slideshowInterval = 5.0
           
           sliderView.contentScaleMode = UIView.ContentMode.scaleAspectFit
           
           let pageIndicator = UIPageControl()
           pageIndicator.currentPageIndicatorTintColor = UIColor(hexString: "005D74")
           pageIndicator.pageIndicatorTintColor = UIColor.gray
           sliderView.pageIndicator = pageIndicator
           //        sliderImg.delegate = self
           
           
           let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeVC.didTap))
           sliderView.addGestureRecognizer(gestureRecognizer)
           sliderView.setImageInputs(sdWebImageSource as! [InputSource])
           
           
           
    }

    
    @objc func didTap() {
        
        
//        let sb = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "fullzoomVC") as! fullzoomVC
//
//
//        if imagArr.count != 0 {
//            vc.imgList = imagArr
//
//            vc.modalPresentationStyle = .fullScreen
//
//            self.present(vc, animated: true, completion: nil)
//
//        }
//
        
        
    }

    func getInstall(){
        DataClient.getCat(success: { (dict) in
          
            self.catData = dict
            self.collectionView.reloadData()
             }, failure: { (err) in
                 
                                self.errorAlert(title: "Alert", body:  err)
                 
             })

    }
    
    
    func getAuctionData(){
           DataClient.getAdvertiseAucations(success: { (dict) in
             
               self.aucationData = dict
            self.sliderImg.removeAll()
            
            for i in dict {
                self.sliderImg.append(i.mediaArry.first?.file ?? "")
            }
        
            if self.sliderImg.count != 0 {
                self.setImageSlideShow()

            }else{
                self.sliderView.isHidden = true
            }

                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
    func setImageSlideShow(){
        
        var sdWebImageSource = [SDWebImageSource(url:  (sliderImg.first?.toURL)! )]
        sdWebImageSource.removeAll()
    
        sliderImg.forEach{
            print($0)
            sdWebImageSource.append(SDWebImageSource(url: ($0.toURL!) ))
        }
        
        sliderView.slideshowInterval = 5.0
        sliderView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor(hexString: "FFC200")
        pageIndicator.pageIndicatorTintColor = UIColor.gray
        
        sliderView.pageIndicator = pageIndicator
        sliderView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
        sliderView.setImageInputs(sdWebImageSource as [InputSource])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSlideShowTapped))
        sliderView.addGestureRecognizer(gestureRecognizer)
        sliderView.addGestureRecognizer(gestureRecognizer)
    }
    
        @objc func imageSlideShowTapped() {

            let index = sliderView.currentPage
            
            let obj = aucationData[index]
            
            
            if obj.code?.contains("noshow") == false {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcuationDetVC") as? AcuationDetVC
                vc?.auctionId = obj.id ?? 0
                    self.navigationController?.pushViewController(vc!, animated: true)

            }
         

         

          }
    

}



extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? CatCollectionViewCell
        
        let obj = catData[indexPath.row]
        cell?.img.sd_setImage(with: obj.image?.toURL, completed: nil)
        cell?.lblTitle.text = obj.name
        
        if obj.auction_count == 0 {
            cell?.notBack.isHidden = true
        }else{
            cell?.notBack.isHidden = false
            cell?.counterCount.text = "\(obj.auction_count ?? 0)"

        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 100, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = catData[indexPath.row]
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CatDetVC") as?  CatDetVC
        vc?.title = obj.name ?? ""
        vc?.catId = obj.id  ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
