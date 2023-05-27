//
//  AuctionHolderViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 14/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import Kingfisher
class AuctionHolderViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var auctionHolderTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var customSegment: CustomSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var auctionHolderImageView: UIImageView!
    
    //MARK: - Properties
    var viewModel:AuctionHolderViewModel
    private var lastContentOffset: CGFloat = 0

    //MARK: - Init
    init(viewModel:AuctionHolderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalize()
        setupViewModelObserver()
        setupTableView()
        setupViewModel()
       // setupUI()
        setupCollectionView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share-line") ?? UIImage(), style: .plain, target: self, action: nil)
    }
    //MARK: - Methods

    private func setupViewModel() {
        viewModel.getHolderPlaces(running: nil, upcoming: nil, expired: nil)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KindOfAuctionCollectionViewCell.nib, forCellWithReuseIdentifier: KindOfAuctionCollectionViewCell.identifier)
    }
    
    private func setupViewModelObserver() {
        viewModel.onError.subscribe { [weak self] error in
            HelperK.showError(title: error.element ?? "", subtitle: "")
          }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { value in
            guard let isLoading = value.element else {return}
             // isLoading ? ActivityIndicatorManager.shared.showProgressView() : ActivityIndicatorManagerr.shared.hideProgressView()
          }.disposed(by: viewModel.disposeBag)
        viewModel.onSuccessGetPlaces.subscribe { [weak self] value in
            self?.tableView.reloadData()
            self?.setupUI()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.kindOfAuction.subscribe { [weak self]value in
            self?.collectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuctionHolderTableViewCell.nib, forCellReuseIdentifier: AuctionHolderTableViewCell.identifier)
    }
    
    private func setupUI() {
        setNavigationItem(title: "AuctionHolder".localize,color: .white)
         let image = viewModel.auctionHolderImage
        guard let url = URL(string: image) else {return}
        let placeholderImage = UIImage(named: "AppIcon")!
        let processor = DefaultImageProcessor.default
        auctionHolderImageView.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        
        auctionHolderTitleLabel.text = viewModel.auctionHolderName
    }
    
    private func setupLocalize() {   

    }

}

extension AuctionHolderViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.onSuccessGetPlaces.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuctionHolderTableViewCell = tableView.dequeue()
        cell.configure(viewModel.onSuccessGetPlaces.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.onSuccessGetPlaces.value[indexPath.row].id else {return}
        let auctionViewModel = AuctionsViewModel(placeId: "\(id)")
        let auctionViewController = AuctionsViewController(viewModel: auctionViewModel)
        navigationController?.pushViewController(auctionViewController, animated: true)
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y <= lastContentOffset) {
            // Move UP - Show Navigation Bar
            collectionView.isHidden = false
            
        } else if (scrollView.contentOffset.y > 0) {
            // Move DOWN - Hide Navigation Bar
            collectionView.isHidden = true
        }
        
        lastContentOffset = scrollView.contentOffset.y
    }
    
}

extension AuctionHolderViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.kindOfAuction.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:KindOfAuctionCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(viewModel.kindOfAuction.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var kindOfCollection = viewModel.kindOfAuction.value
        guard let index =  kindOfCollection.firstIndex(where: {$0.selected == true}) else {return}
        kindOfCollection[index].selected = false
        kindOfCollection[indexPath.row].selected = true
        viewModel.kindOfAuction.accept(kindOfCollection)
        guard let auctionState = AuctionState(rawValue: indexPath.row) else {return}
        getAuctionHolder(state: auctionState)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 50)
    }
    
    private func getAuctionHolder(state:AuctionState) {
        switch state {
        case .all:
            viewModel.getHolderPlaces(running: nil ,upcoming: nil, expired: nil)
        case .running:
            viewModel.getHolderPlaces(running: true, upcoming: nil, expired: nil)
        case .upcoming:
            viewModel.getHolderPlaces(running: nil, upcoming : true , expired: nil)
        case .expired:
            viewModel.getHolderPlaces(running: nil, upcoming : nil , expired: true)

        }
    }
}

enum AuctionState:Int {
    case all = 0
    case running
    case upcoming
    case expired
}

extension UIViewController {
    func setNavigationItem(title:String, color: UIColor = .clear){
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = title
//        navigationController?.navigationBar.backgroundColor = color
//
        navigationController?.navigationBar.tintColor = .Bronze_500
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.compact)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        let titleLabel = UILabel()
        navigationItem.backButtonTitle = ""
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = UIColor.textColor
        titleLabel.font = UIFont(name: "Cairo-Regular", size: 20)
        self.navigationItem.titleView = titleLabel
       
    }
  
}
