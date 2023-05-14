//
//  AskGoldenBellViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 27/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
class AskGoldenBellViewController: UIViewController {

    @IBOutlet weak var decorationView: UIView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel:AskGoldenBellViewModel
    init(viewModel:AskGoldenBellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModelObservers()
        setupViewModel()
        setupViews()
        setupTableView()
        setupUI()
    }
    
    private func setupViewModel() {
        viewModel.getGoldenBell()
    }
    
    private func setupUI() {
        decorationView.setRoundCorners(15)
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] _ in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccessGetAllCats.subscribe { [weak self] _ in
            self?.collectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccessGetAllCats.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
    }

    private func setupViews() {
        headerView.configure(.askGoldenBell)
        headerView.onTapNotification = {[weak self] in
            let notificationViewModel =  NotificationsViewModel()
            let notificationViewController = NotificationsViewController(viewModel:notificationViewModel)
            notificationViewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(notificationViewController, animated: true)
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AskGoldenBellTableViewCell.nib, forCellReuseIdentifier: AskGoldenBellTableViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)

    }
    
    
    func openMaps(auction:AllAdvertisement) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "Google", style: .default , handler:{ (UIAlertAction)in
               self.openGoogle(lat: auction.latitude ?? ""  , lon: auction.longitude ?? "" )
           }))
           
           alert.addAction(UIAlertAction(title: "Apple", style: .default , handler:{ (UIAlertAction)in
               self.openApple(lat: auction.latitude ?? "", lon: auction.longitude ?? "", name: auction.name ?? "")
           }))

           

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
        

    }
    
    private func openApple(lat:String,lon:String,name:String) {
        HelperK.openMapOnAddress(long: lat , lat: lon  , name:  name)

    }
    
    private func openGoogle(lat:String,lon:String) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app

            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving") {
                      UIApplication.shared.open(url, options: [:])
             }}
        else {
               //Open in browser
              if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(lon)&directionsmode=driving") {
                                 UIApplication.shared.open(urlDestination)
                             }
                  }

    }
 
}

extension AskGoldenBellViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.onSuccessGetAllAds.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AskGoldenBellTableViewCell = tableView.dequeue()
        cell.configure(viewModel.onSuccessGetAllAds.value[indexPath.row])
         let item = viewModel.onSuccessGetAllAds.value[indexPath.row]
        cell.onTapMap = {[weak self] in
           
            self?.openMaps(auction: item)
            
        }
        
        cell.onTapCall = {[weak self] in
            HelperK.openCalling(phone: item.phone ?? "")
            
        }
        cell.onTapChat = { [weak self] in
            HelperK.openWhatsapp(phone: item.phoneWhatsapp ?? "")
        }
        return cell
    }
    
    
}

extension AskGoldenBellViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.onSuccessGetAllCats.value.count
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CategoryCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(viewModel.onSuccessGetAllCats.value[indexPath.row])
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.onSuccessGetAllCats.value[indexPath.row].id else {return}
        viewModel.getGoldenBell(id: id)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let language =   LocalizationManager.shared.getLanguage()
        
        guard let widthInEnglish = viewModel.onSuccessGetAllCats.value[indexPath.row].name?.widthOfString(usingFont:.Archivo(18,weight: .Bold)) else {return CGSize(width: 100 , height: 48)}
        
        guard let widthInArabic = viewModel.onSuccessGetAllCats.value[indexPath.row].nameAr?.widthOfString(usingFont:.Archivo(18,weight: .Bold)) else {return CGSize(width: 100 , height: 48)}
        
        return  language == .Arabic ?  CGSize(width: widthInArabic + 65, height: 48): CGSize(width: widthInEnglish + 65, height: 48)
    }
    
}
