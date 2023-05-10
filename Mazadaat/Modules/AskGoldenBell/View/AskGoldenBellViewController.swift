//
//  AskGoldenBellViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 27/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

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
        collectionView.register(KindOfAuctionCollectionViewCell.nib, forCellWithReuseIdentifier: KindOfAuctionCollectionViewCell.identifier)

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
           
            HelperK.openMapOnAddress(long: item.longitude ?? "", lat: item.latitude ?? "" , name: item.name ?? "")
            
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
        let cell:KindOfAuctionCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(viewModel.onSuccessGetAllCats.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var kindOfCollection = viewModel.onSuccessGetAllCats.value
//        guard let index =  kindOfCollection.firstIndex(where: {$0.selected == true}) else {return}
//        kindOfCollection[index].selected = false
//        kindOfCollection[indexPath.row].selected = true
//        viewModel.onSuccessGetAllCats.accept(kindOfCollection)
//        guard let auctionState = AuctionState(rawValue: indexPath.row) else {return}
        //getAuctionHolder(state: auctionState)
        
    }
    
    
    
}
