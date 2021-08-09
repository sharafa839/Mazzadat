//
//  AcuationDetVC.swift
//  Mazadaat
//
//  Created by macbook on 10/26/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import ImageSlideshow
import FirebaseFirestore
import Firebase
import MapKit
class AcuationDetVC: UIViewController, MyDataSendingDelegateProtocolAuction,MyDataSendingActiveVC, MyDataSendingDelegateProtocol,getRolePageProtocol,ProtoctolGoTOPakages {
    func goToPakegs(reload: Bool) {
        let story = UIStoryboard(name: "Main", bundle:nil)

        let vc = story.instantiateViewController(withIdentifier: "PakagesVC") as? PakagesVC

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
    func gotoRolesPAge(myData: String) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
        vc?.isTerm = true
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func sendDataToFirstViewController(myData: String) {
        self.getAuctionData(id: auctionId ?? 0)
    }
    
    func sendDataToFirstViewControllerAuction(myData: AuctionsOB) {
//        aucationData = myData
        
        
        getDataReal(id: auctionId ?? 0)
        
        if    self.acutionNumber.text == "0 مزايدة" {
            self.acutionNumber.text = "1 مزايدة"
        }
    }
    
    func goToActiveVC(myData: String) {
        verifyData()
    }
    
    @IBOutlet weak var showSpsifcButton: UIButton!
    @IBOutlet weak var lblTimeTitleState: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var notStartLable: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var nowPriceTitleLbl: UILabel!
    @IBOutlet weak var highPriceView: DesignableView!
    @IBOutlet weak var auctionStaetLabel: UILabel!
    @IBOutlet weak var mapLabelPrice: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var cuurentPriceLabel: UILabel!
    @IBOutlet weak var mapV: MKMapView!
    @IBOutlet weak var acoutinNumberLabel: UILabel!
    @IBOutlet weak var sliderView: ImageSlideshow!
    @IBOutlet weak var acutionNameLAbel: UILabel!
    @IBOutlet weak var acutionNumber: UILabel!
    @IBOutlet weak var acutionTime: UILabel!
    @IBOutlet weak var acutionNowPrice: UILabel!
    @IBOutlet weak var auctionBtnn: UIButton!
    @IBOutlet weak var auctionBtn: DesignableView!
    @IBOutlet weak var showTitle: UILabel!
    
    
    var releaseDate: Date?
    var countdownTimer = Timer()
    var notiId = 0
    var refreshControl = UIRefreshControl()
    var aucationData: AuctionsOB?
    var auctionId : Int?
    var endtDate = Date()
    var imgSlider:[String]=[]
    var isNoti = false
    let db = Firestore.firestore()
    var showNoti = false
    var myBids: [AuctionsOB]=[]

    let notificationContent = UNMutableNotificationContent()
    let userNotificationCenter = UNUserNotificationCenter.current()
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
    repeats: false)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isNoti{
            readNoti(notiId: notiId ?? 0)
        }
        
      
        getAuctionData(id: auctionId ?? 0)
        getAuctinRealTime()
        
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//              self.navigationController?.navigationBar.shadowImage = UIImage()
//              self.navigationController?.navigationBar.isTranslucent = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        scrollView.addSubview(refreshControl) // not required when using UITableViewController
        
        
        if AppData.isLogin == true {
            getUser()
            getAuctionData()

        }
    }
    
    func readNoti(notiId: Int){
           DataClient.readNoti(notiId: notiId,success: { (dict) in
                print("Done")
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })
       }
    
    
    func getAuctionData(){
           DataClient.getMyAucations(success: { (dict) in
             
               self.myBids = dict

                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })
       }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        

//        self.navigationController?.navigationBar.tintColor = UIColor.black
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                    self.navigationController?.navigationBar.shadowImage = UIImage()
//                    self.navigationController?.navigationBar.isTranslucent = false
    }
    

    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.getAuctionData(id: auctionId ?? 0)
    }
    

    func setAucationData(){
    
        switch aucationData?.status {
        case 0:
            print("WaitingCustomerPayment")
            
            self.auctionStaetLabel.text = "بانتظار البدأ".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            self.restTimeLabel.text = aucationData?.start_at ?? ""
            self.lblTimeTitleState.text = "وقت البدأ".localized
                   
        case 1:
            self.auctionStaetLabel.text = "جاري المزايدة".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.nowPriceTitleLbl.isHidden = false
            self.highPriceView.isHidden = true
            
//            self.setupCountDownLabelTimer(stop: false)

            self.startTimer()
        case 2:
            print("WaitingSupplierApproval")
            
            self.auctionStaetLabel.text = "في انتظار موافقة المورد".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.6175402403, green: 0.108195059, blue: 0.6995844841, alpha: 1)
            
            self.nowPriceTitleLbl.isHidden = true
            if aucationData?.LastBid?.user_id == AppData.userId {
                self.highPriceView.isHidden = false
            }
            
            self.restTimeLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)

            self.restTimeLabel.text = aucationData?.end_at ?? ""
            self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
            
        case 3:
            print("WaitingCustomerPayment")
            
            self.auctionStaetLabel.text = "في انتظار دفع العميل".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.6175402403, green: 0.108195059, blue: 0.6995844841, alpha: 1)
            
            self.nowPriceTitleLbl.isHidden = true
            if aucationData?.LastBid?.user_id == AppData.userId {
                self.highPriceView.isHidden = false
                
            }
            
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
            
        case 4:
            print("WaitingStart")
            self.auctionStaetLabel.text = "تم الانتهاء".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)
            
            self.nowPriceTitleLbl.isHidden = true
            if aucationData?.LastBid?.user_id == AppData.userId {
                self.highPriceView.isHidden = false
            }
            self.restTimeLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)
            self.restTimeLabel.text = aucationData?.end_at ?? ""
            self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
            
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
            
        case 5:
            print("WaitingStart")
            print("WaitingStart")
            self.auctionStaetLabel.text = "تم الغاء من طرف المورد".localized
                    self.auctionStaetLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)
                    
                    self.nowPriceTitleLbl.isHidden = true
                    if aucationData?.LastBid?.user_id == AppData.userId {
                        self.highPriceView.isHidden = false
                    }
            
            self.restTimeLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)
            self.restTimeLabel.text = aucationData?.end_at ?? ""
            self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
            
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
        case 6:
            print("WaitingStart")
            self.auctionStaetLabel.text = "تم الغاء العميل".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)
            
            self.nowPriceTitleLbl.isHidden = true
            if aucationData?.LastBid?.user_id == AppData.userId {
                self.highPriceView.isHidden = false
            }
            self.restTimeLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)

            self.restTimeLabel.text = aucationData?.end_at ?? ""
            self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
            
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
        case 7:
            
            self.auctionStaetLabel.text = "المزاد انتهى بدون مزايدة".localized
            self.auctionStaetLabel.textColor = #colorLiteral(red: 0.923761785, green: 0.1547688842, blue: 0.4219938517, alpha: 1)

            print("WaitingStart")
            
            auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            auctionBtnn.isUserInteractionEnabled = false
            
        default:
            break
        }
        if let endtDate =  (aucationData?.end_at?.toDate()?.date)  {
            
            if endtDate < Date(){
                auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
                auctionBtn.topColor = UIColor(hexString: "C4C4C4")
                auctionBtnn.isUserInteractionEnabled = false
                
            }
            
        }
        
        
//        mapV.isUserInteractionEnabled = false
        
        
        
        
        if aucationData?.LastBid?.price == "" ||  self.aucationData?.LastBid?.price == nil {
            self.cuurentPriceLabel.text = "\(aucationData?.price ?? "") \("ر.س".localized)"
            
        }else{
            self.cuurentPriceLabel.text = "\(aucationData?.LastBid?.price ?? "") \("ر.س".localized)"
            
        }
        self.navigationItem.title = "#\(aucationData?.code ?? "")"
        self.acutionNameLAbel.text = aucationData?.name ?? ""
        self.acutionNowPrice.text = "\(aucationData?.minimum_bid ?? "") \("ر.س".localized)"
        self.lblDesc.text =    aucationData?.description ?? ""
        
        if aucationData?.is_favourite == true {
            self.likeBtn.setImage(#imageLiteral(resourceName: "2www"), for: .normal)
        }else{
            
            self.likeBtn.setImage(#imageLiteral(resourceName: "Group 55064"), for: .normal)
            
        }
        
        self.acutionNumber.text =  "\(self.aucationData?.bids_count ?? 0) \("مزايدة".localized)"
        self.acutionTime.text = aucationData?.end_at
    }
    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//              self.navigationController?.navigationBar.shadowImage = UIImage()
//              self.navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @IBAction func showMapApp(_ sender: Any) {
//        openMaps()
        openMapButtonAction()

//        openGoogleMaps()
    }

    
    func openMapButtonAction() {
        
        let latitude = Double(aucationData?.lat ?? "0.0")
        let longitude = Double(aucationData?.lng ?? "0.0")

//            let appleURL = "http://maps.apple.com/?daddr=\(24.7255553),\(46.5423359)"
//            let googleURL = "comgooglemaps://?daddr=\(24.7255553),\(46.5423359)&directionsmode=driving"
//
//        let googleItem = ("Google Map".localized, URL(string:googleURL)!)
//        var installedNavigationApps = [("Apple Maps".localized, URL(string:appleURL)!)]
//
//            if UIApplication.shared.canOpenURL(googleItem.1) {
//                installedNavigationApps.append(googleItem)
//
//            }
//
//
//            let alert = UIAlertController(title: "Selection", message: "Select Navigation App", preferredStyle: .actionSheet)
//            for app in installedNavigationApps {
//                let button = UIAlertAction(title: app.0, style: .default, handler: { _ in
//                    UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
//                })
//                alert.addAction(button)
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(cancel)
//            present(alert, animated: true)
//
//
        
        let alert = UIAlertController(title: "خرائط", message: nil, preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title:" Google Map".localized, style: .default, handler: { _ in
//            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//                UIApplication.shared.openURL(URL(string:"comgooglemaps://?center=37.788463,-122.392545&zoom=12")!)
//            } else {
//                print("Can't use comgooglemaps://")
//            }
//
            
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude ?? 0.0),\(longitude ?? 0.0)&zoom=14&views=traffic&q=\(latitude ?? 0.0),\(longitude ?? 0.0)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude ?? 0.0),\(longitude ?? 0.0)&zoom=14&views=traffic&q=\(latitude ?? 0.0),\(longitude ?? 0.0)")!, options: [:], completionHandler: nil)
            }

          }))
          
          alert.addAction(UIAlertAction(title: "Apple Maps".localized, style: .default, handler: { _ in
            self.openMaps()


         

          }))
        
       
          
          alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

          self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
        }
    
    func openGoogleMap() {
        
//        openMaps()
//    let long = aucationData?.lng
//        let lat = aucationData?.lat
//
//          if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
//
//              if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
//                        UIApplication.shared.open(url, options: [:])
//               }}
//          else {
//                 //Open in browser
//                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
//                                   UIApplication.shared.open(urlDestination)
//                               }
//                    }

            }
    
    func openMaps() {
        
        
        
        let locationLat = Double(aucationData?.lat ?? "0.0")
        let locationlong = Double(aucationData?.lng ?? "0.0")

//
//        let geocoder = CLGeocoder()
//            let str = "1600 Pennsylvania Ave. 20500" // A string of the address info you already have
//            geocoder.geocodeAddressString(str) { (placemarksOptional, error) -> Void in
//              if let placemarks = placemarksOptional {
//                print("placemark| \(placemarks.first)")
//                if let location = placemarks.first?.location {
//                  let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
//                  let path = "http://maps.apple.com/" + query
//                  if let url = NSURL(string: path) {
//                    UIApplication.shared.openURL(url as URL)
//                  } else {
//                    // Could not construct url. Handle error.
//                  }
//                } else {
//                  // Could not get a location from the geocode request. Handle error.
//                }
//              } else {
//                // Didn't get any placemarks. Handle error.
//              }
//            }

        let coordinates = CLLocationCoordinate2DMake(locationLat ?? 0.0, locationlong ?? 0.0)

        let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)

        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)

        let mapItem = MKMapItem(placemark: placemark)

        mapItem.name = aucationData?.name ?? ""

        mapItem.openInMaps(launchOptions:[
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
        ] as [String : Any])
        
    }
    
    func openGoogleMaps() {
        
//        let long = aucationData?.lng
//            let lat = aucationData?.lat
//
//              if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
//
//                  if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
//                            UIApplication.shared.open(url, options: [:])
//                   }}
//              else {
//                     //Open in browser
//                    if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
//                                       UIApplication.shared.open(urlDestination)
//                                   }
//                        }
//        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(aucationData?.lat),\(aucationData?.lang)&zoom=14&views=traffic&q=\(aucationData?.lat),\(aucationData?.lang)")!, options: [:], completionHandler: nil)
//        } else {
//
//            let testURL = URL(string: "comgooglemaps-x-callback://")!
//            if UIApplication.shared.canOpenURL(testURL) {
//              let directionsRequest = "comgooglemaps-x-callback://" +
//                "?daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York" +
//                "&x-success=sourceapp://?resume=true&x-source=AirApp"
//
//              let directionsURL = URL(string: directionsRequest)!
//              UIApplication.shared.openURL(directionsURL)
//            } else {
//              NSLog("Can't use comgooglemaps-x-callback:// on this device.")
//            }
//
//        }
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        
        
        
        
        let text1 = "\(aucationData?.name ?? "" ) \n \(aucationData?.code ?? "")"

        let image = #imageLiteral(resourceName: "Group 55047")
        let myWebsite = NSURL(string:"https://apps.apple.com/us/app/golden-bell/id1542439385")
        
        let shareAll = [text1 , image , myWebsite] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
        
        
        
//        UIApplication.share("https://apps.apple.com/us/app/golden-bell/id1542439385")
//
//        // Take snapshot of screen
//        var imageSnapshot: UIImage!
//        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
//        self.view.drawHierarchy(in: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), afterScreenUpdates: false)
//        imageSnapshot = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        // Prepare text to share
//        let textShare: String!
//        textShare = "https://apps.apple.com/us/app/golden-bell/id1542439385"
//
//        let textShare2 = "\(aucationData?.name ?? "")"
//        let textShare3 = "\(aucationData?.code ?? "")"
//
//        // Prepare image to share
//        let imageShareData: NSData
//        imageShareData = imageSnapshot.pngData()! as NSData
//        let imageShare = UIImage(data: imageShareData as Data)!
//
//        // Share text and image
//        let activity = UIActivityViewController(activityItems: [textShare,textShare2,textShare3, imageShare], applicationActivities: nil)
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.present(activity, animated: true, completion: nil)
//        }
//

    }
    
    @IBAction func rolesTapped(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "AuctionRolesVC") as?  AuctionRolesVC
                  vc?.auctionData   = aucationData
        vc?.delegate = self
                  self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func chatTapped(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func sendLocalNotifucation(title:String, body: String, badgeNumber: Int, sender: String){
         
        
        
        NotificationCenter.default.post(name: Notification.Name("reloadTimer"), object: nil)

         let notificationContent = UNMutableNotificationContent()
            notificationContent.title = title
            notificationContent.body = body
         notificationContent.userInfo = ["sender":sender,"chatType":"chat"]
         notificationContent.sound = UNNotificationSound.default


            
            if let url = Bundle.main.url(forResource: "dune",
                                        withExtension: "png") {
                if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                url: url,
                                                                options: nil) {
                    notificationContent.attachments = [attachment]
                }
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                            repeats: false)
            let request = UNNotificationRequest(identifier: "testNotification",
                                                content: notificationContent,
                                                trigger: trigger)
            
            userNotificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        
        countdownTimer.invalidate()
        
//        setupCountDownLabelTimer(stop: true)
        getAuctionData(id: auctionId ?? 0)
     }
     
     
    
    func verifyData(){
        DataClient.verifyEmail(type:1,success: { (dict) in
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VerfiyCodeVC") as?  VerfiyCodeVC
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    func getAuctinRealTime(){
        DataClient.getRealTimeAucation(auctionId: auctionId  ?? 0 ,success: { (dict) in
            
            print("xxx")
            
            var arry = dict.sorted(by: {
                if let lhsDate = $0.time , let rhsDate = $1.time {
                    return lhsDate.compare(rhsDate) == .orderedDescending
                } else {
                    return false
                }
            })
            
            
            if  arry.count != 0 {
                
//                self.getAuctionData(id: self.auctionId ?? 0)
                
                self.mapLabelPrice.text = "\(arry.first?.price ?? "") ر.س\("ر.س".localized)"
                self.cuurentPriceLabel.text = "\(arry.first?.price ?? "") ر.س\("ر.س".localized)"
                
                if self.showNoti {
                    
                    
                    if self.myBids.contains(where: {$0.id == self.auctionId }) {
                        self.sendLocalNotifucation(title: "\(Date().toArString(format: "E, d MMM yyyy HH:mm:ss Z"))", body: "\(arry.first?.price ?? "") \("ر.س".localized)", badgeNumber: 0, sender: "")
                      
                      
                      self.getDataReal(id: self.auctionId ?? 0)
                    }

                
                }
             
                
                if arry.first?.user_id == "\(AppData.userId)" {
                           self.highPriceView.isHidden = false
                    self.nowPriceTitleLbl.isHidden = true
                    
                  
                }else{
                     self.highPriceView.isHidden = true
                    self.nowPriceTitleLbl.isHidden = false
                }
            }
            

            
            self.showNoti = true
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    
    func getAuctionData(id: Int){
        DataClient.getSingleAucations(auctionId:id,success: { (dict) in
            
    
            self.aucationData = dict
            
            
            if dict.AuctionDet.count == 0 {
                self.showTitle.text = "لايوجد".localized
                self.showSpsifcButton.isUserInteractionEnabled = false
            }else{
                self.showTitle.text = "عرض".localized
                self.showSpsifcButton.isUserInteractionEnabled = true
            }
            
            self.setImageSlideShow()
            self.setupMap()
            self.setAucationData()

            
            
            if self.aucationData?.LastBid?.user_id == AppData.userId {
                       self.highPriceView.isHidden = false
                self.nowPriceTitleLbl.isHidden = true
                
              
            }else{
                 self.highPriceView.isHidden = true
                self.nowPriceTitleLbl.isHidden = false
            }
            
            if self.aucationData?.LastBid?.price == "" || self.aucationData?.LastBid?.price == nil {
                self.cuurentPriceLabel.text = "\(self.aucationData?.price ?? "" )\("ر.س".localized)"
                self.mapLabelPrice.text = "\(self.aucationData?.price ?? "") \("ر.س".localized)"
                
            }else{
                self.cuurentPriceLabel.text = "\(self.aucationData?.LastBid?.price ?? "") \("ر.س".localized)"
                self.mapLabelPrice.text = "\(self.aucationData?.LastBid?.price ?? "")\("ر.س".localized)"
                
            }
            
            
            
            if dict.is_favourite == true {
                self.likeBtn.setImage(#imageLiteral(resourceName: "2www"), for: .normal)
            }else{
                
                self.likeBtn.setImage(#imageLiteral(resourceName: "Group 55064"), for: .normal)
                
            }
            
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    
    
    func getDataReal(id: Int){
        DataClient.getSingleAucations(auctionId:id,success: { (dict) in
            
            
            self.aucationData = dict

            
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    func getUser(){
           DataClient.getMyProfile(success: { (dict) in
             
                if dict.email_verified_at == "" {
                                         AppData.isVeerfiyEmail = false
                                     }else{
                                         AppData.isVeerfiyEmail = true

                                     }
      
            
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }
    
    
    
    
    @IBAction func addAcution(_ sender: Any) {
        
        
        if AppData.isLogin == false {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginAlertVC") as?  LoginAlertVC
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.modalPresentationStyle = .overCurrentContext

            
            self.present(vc!, animated: true, completion: nil)
            return
        }
        if AppData.isVeerfiyEmail == false {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.titleStr = "معلومات".localized
            vc?.titleDec = "حسابك غير مفعل ,قم بتفعيل حسابك يتم ارسال رسالة بها رمز التفعيل على رقم موبايلك, ويمكنك ايضاً طلب رمز جديد هل تريد ؟التفعيل الان".localized
            
            vc?.isActivealert = true
            vc?.activeDelegate = self
            vc?.ConfirmBtnStr = "قم بالتفعيل".localized
            
            self.present(vc!, animated: true, completion: nil)
            
        }else if aucationData?.status == 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
                    vc?.modalTransitionStyle   = .crossDissolve;
                    vc?.modalPresentationStyle = .overCurrentContext
                    vc?.modalPresentationStyle = .overCurrentContext
            vc?.titleStr = "معلومات".localized
            vc?.titleDec = "هذا المزاد لم يبدأ بعد يمكنك الانتظار حتى يبدأ المزاد لتستطيع المزايدة!".localized
                    vc?.isActivealert = true
            vc?.isConfirmHide = true
            vc?.isHide = false

                    vc?.activeDelegate = self
            vc?.ConfirmBtnStr = "اغلاق".localized
                   vc?.cncelViewColor = #colorLiteral(red: 1, green: 0.6019695997, blue: 0.1917569339, alpha: 1)
      self.present(vc!, animated: true, completion: nil)
            
            
        } else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PopViewVC") as?  PopViewVC
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.delegate = self
            vc?.delegatePak = self
            vc?.aucationData = aucationData
            vc?.auctionId = auctionId ?? 0
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    
    
    func addLike(id:Int){
        
        DataClient.addFave(auctionId:id,success: { (dict) in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC") as?  AlertVC
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.delegate = self
            vc?.titleDec = dict
            vc?.ConfirmBtnStr = "موافق".localized
            vc?.isHide = true
            self.present(vc!, animated: true, completion: nil)
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
        
    }
    
    
    
    // SetUpCounterLabel
    func stopTimer(){
        
        
        
        let endDate = aucationData?.end_at
        // Start Timer
        TimerManagerr(interval: 0, endDate: endDate ?? "", stopTimer: true, repeats: false){day, hours, minutes, seconds, hideOfferView  in
            if hideOfferView == true {
                print("Hide")
         self.restTimeLabel.text = "0"

            }

        }.start()
        
    }
    // SetUpCounterLabel
    func setupCountDownLabelTimer(stop:Bool){
        
        
        
        let endDate = aucationData?.end_at
        // Start Timer
        TimerManagerr(interval: 1, endDate: endDate ?? "", stopTimer: stop, repeats: true){day, hours, minutes, seconds, hideOfferView  in
            
            //                      if hideOfferView == true {
            //                          return
            //                      }
            
            
            if seconds.contains("-"){
                self.restTimeLabel.text = endDate ?? ""
                self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
                self.restTimeLabel.textColor = .red
                self.auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
                self.auctionBtn.topColor = UIColor(hexString: "C4C4C4")
                self.auctionBtnn.isUserInteractionEnabled = false
//                self.getAuctionData(id: self.auctionId ?? 0)

                return
            }
            
//            if hideOfferView {
//                self.restTimeLabel.text = endDate ?? ""
//                self.lblTimeTitleState.text = "المزاد منتهي منذ"
//            }else{
//                self.setOfferTimerLalbel(days: day, hours: hours, minutes: minutes, seconds: seconds)
//
//
//            }
//
            
            
            if hideOfferView{
                return
            }
                 self.setOfferTimerLalbel(days: day, hours: hours, minutes: minutes, seconds: seconds)
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
    
    
    
    
    
    
    func startTimer() {
        let releaseDateString = "2019-02-23 08:00:00"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate  = aucationData?.end_at?.toDateNew()


        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTime()
        }
    }

    func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current


        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate!)

        let secounds = "\(diffDateComponents.second ?? 0)"
   
        if secounds.contains("-"){
            self.restTimeLabel.text = aucationData?.end_at ?? ""
            self.lblTimeTitleState.text = "المزاد منتهي منذ".localized
            self.restTimeLabel.textColor = .red
            self.auctionBtn.bottomColor = UIColor(hexString: "C4C4C4")
            self.auctionBtn.topColor = UIColor(hexString: "C4C4C4")
            self.auctionBtnn.isUserInteractionEnabled = false
//                self.getAuctionData(id: self.auctionId ?? 0)

            return
        }
        
        restTimeLabel.text = "\(diffDateComponents.day ?? 0)ي \(diffDateComponents.hour ?? 0)س \(diffDateComponents.minute ?? 0)د \(diffDateComponents.second ?? 0)ث "

    }
    
    func setOfferTimerLalbel(days: String, hours: String, minutes: String, seconds: String){
        restTimeLabel.text = "\(days)ي \(hours)س \(minutes)د \(seconds)ث "
    }
    func setImageSlideShow(){
        
        var sdWebImageSource = [SDWebImageSource(url:  (aucationData?.mediaArry?.first?.file?.toURL)! )]
        sdWebImageSource.removeAll()
        
        aucationData?.mediaArry.forEach{
            print($0)
            sdWebImageSource.append(SDWebImageSource(url: ($0.file?.toURL!)! ))
        }
        
        sliderView.slideshowInterval = 5.0
        sliderView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor(hexString: "FFC200")
        pageIndicator.pageIndicatorTintColor = UIColor.gray
        
        sliderView.pageIndicator = pageIndicator
        sliderView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customTop(padding: 200))
        
        sliderView.setImageInputs(sdWebImageSource as [InputSource])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSlideShowTapped))
        sliderView.addGestureRecognizer(gestureRecognizer)
        sliderView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @IBAction func likeBtn(_ sender: Any) {
        
        addLike(id: aucationData?.id ?? 0)
        
        
        
        
        
        
    }
    
    
    @IBAction func detTapped(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "AuctionSpesifcationVC") as?  AuctionSpesifcationVC
        
        if let arr = aucationData?.AuctionDet {
                 vc?.auctionSp   = arr
        }
 
            
                  self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func imageSlideShowTapped() {
        
        sliderView.presentFullScreenController(from: self)

        //          // AMPLITUDE
        //          var eventProperties: [AnyHashable : Any] = [:]
        //          eventProperties["Venue Name"] = self.venue.name
        //          eventProperties["Price Description"] = self.venue.textPrice
        //
        //          AmplitudeManager.logEvent(eventName: Constants.Amplitude.Events.ClickPhotos, eventProperties: eventProperties)
        //
        //          imageSlideShowView.presentFullScreenController(from: self)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setupMap(){
        if aucationData?.lat == nil || aucationData?.lng == nil {
            //             self.extraInfoStackView.viewWithTag(100)?.isHidden = true
        }
        else{
            
            //Create the pin location of your restaurant(you need the GPS coordinates for this)
//            let restaurantLocation = CLLocationCoordinate2D(latitude: Double(aucationData?.lng ?? "") ?? 0.0, longitude: Double(aucationData?.lng ?? "") ?? 0.0)

                  //Center the map on the place location
            
            
//                  mapV.setCenter(restaurantLocation, animated: true)
            
//
            let initialLocation = CLLocation(latitude: 46.5423359, longitude: 24.7255553)
                self.centerMapOnLocation(location: initialLocation)
//
            
//            let restaurantLocation = CLLocationCoordinate2D(latitude: 46.5423359, longitude: 24.7255553)
//
//                  //Center the map on the place location
//            
//                  mapV.setCenter(restaurantLocation, animated: true)
            
        }
        
        if self.aucationData?.LastBid?.price == "" ||  self.aucationData?.LastBid?.price == nil {
            self.mapLabelPrice.text = "\(aucationData?.price ?? "")\("ر.س".localized)"
            
        }else{
            self.mapLabelPrice.text = "\(aucationData?.LastBid?.price ?? "") \("ر.س".localized)"
            
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: atof(aucationData?.lat ?? ""), longitude: atof(aucationData?.lng ?? "")), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
       DispatchQueue.main.async {
           self.mapV.setRegion(region, animated: true)
           let annotation = MKPointAnnotation()
           annotation.coordinate = location.coordinate
           self.mapV.addAnnotation(annotation)
       }
   }
    
//    
//    func GetAnnotationUsingCoordinated(_ location : CLLocation) {
//
//        //get current address from geocode from apple, from location lat long
//        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate) { (response, error) in
//
//        }
//
//    }
    
}

