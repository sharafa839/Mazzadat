//
//  HomeViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 04/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import ImageSlideshow
class HomeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var headerHomeView: HeaderHomeView!
    @IBOutlet weak var packageSubscribePlan: PackageSubscribePlan!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    
    @IBOutlet weak var auctionHolderCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    //MARK: - Properties
    var imageSource = [InputSource]()
    var viewModel:HomeViewModel
    var screenSize: CGRect!
       var screenWidth: CGFloat!
       var screenHeight: CGFloat!
    //MARK: - Init
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalize()
        setupViewModelObserver()
        setupSlider()
        setupCollectionViews()
        setupViewModel()
        setupLayout()
       setupViewsAction()
        
    }
    
    func setupLayout() {
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight =  categoryCollectionView.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = !(CoreData.shared.personalSubscription?.isEmpty ?? false) ?  CGSize(width: screenWidth/4, height: screenHeight/2.3) : CGSize(width: screenWidth/3.5, height: screenHeight/2)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        categoryCollectionView.collectionViewLayout = layout
        let auctionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        auctionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        auctionLayout.itemSize = CGSize(width: 140, height: 140)
        auctionLayout.scrollDirection = .horizontal
        auctionLayout.minimumInteritemSpacing = 0
        auctionLayout.minimumLineSpacing = 0
        auctionHolderCollectionView.collectionViewLayout = auctionLayout

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    private func setupViewModel() {
        viewModel.getSlider()
        viewModel.getAuctionHolders()
    }
    
    private func setupUI () {
        continerView.setRoundCorners(5)
        packageSubscribePlan.setRoundCorners(5)
       packageSubscribePlan.isHidden = (CoreData.shared.personalSubscription?.isEmpty ?? false)
        headerHomeView.setupUI(view: .home)
    }
    
    private func setupLocalize() {
        
    }
    
    private func setupCollectionViews() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        auctionHolderCollectionView.delegate = self
        auctionHolderCollectionView.dataSource = self
        auctionHolderCollectionView.register(AuctionHolderCellCollectionViewCell.nib, forCellWithReuseIdentifier: AuctionHolderCellCollectionViewCell.identifier)
        
    }
    
    private func setupViewModelObserver() {
      viewModel.onSuccessGetImageSlider.subscribe { [weak self] sliders in
          guard let slider = sliders.element else {return}
        guard let self = self else {return}
        self.imageSource.removeAll()
          for media in slider {
              guard let images = media.media else {return}
              for image in images {
                  guard let url = image.file else {return}
                  ActivityIndicatorManager.shared.hideProgressView()
                guard let king = KingfisherSource(urlString: url) else {return}
                self.imageSource.append(king)
                                         
                DispatchQueue.main.async {
                  self.imageSlider.setImageInputs(self.imageSource)

                }
              }
          }
      }.disposed(by:viewModel.disposeBag)
      
      viewModel.onSuccessGetCategories.subscribe { [weak self] _ in
        self?.categoryCollectionView.reloadData()
      }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccessGetAuctionHolders.subscribe { [weak self] _ in
          self?.auctionHolderCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)
          
        viewModel.onError.subscribe { [weak self] error in
            HelperK.showError(title: error.element ?? "", subtitle: "")
          }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { [weak self] value in
            guard let isLoading = value.element else {return}
              isLoading ? ActivityIndicatorManager.shared.showProgressView() : ActivityIndicatorManagerr.shared.hideProgressView()
          }.disposed(by: viewModel.disposeBag)
    }
    //MARK: - Methods
    
    private func setupSlider() {
        self.imageSlider.configSliderShow()
        self.imageSlider.setRoundCorners(15)
        self.imageSlider.addActionn(vc: self, action: #selector(didTab))
    }
    
    @objc func didTab()  {
        imageSlider.presentFullScreenController(from: self)
    }
    
    private func setupViewsAction() {
        packageSubscribePlan.onTapUpgrade = {[weak self]   in
            
            print("package")
            
        }
        
        headerHomeView.onTapNotification = { [weak self] in
//            let notificationViewModel =  NotificationsViewModel()
//            let notificationViewController = NotificationsViewController(viewModel:notificationViewModel)
//            self?.navigationController?.pushViewController(notificationViewController, animated: true)
//        }
        } 
        
        headerHomeView.onTapSearch = { [weak self] in
                        let notificationViewModel =  ProfileViewModel()
                        let notificationViewController = ProfileViewController(viewModel:notificationViewModel)
                        self?.navigationController?.pushViewController(notificationViewController, animated: true)
                    }
        
    }
    
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
        return CoreData.shared.categories?.count ?? 0
        } else {
            return viewModel.onSuccessGetAuctionHolders.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
        let cell:CategoriesCollectionViewCell = collectionView.dequeue(at: indexPath)
        guard let category = CoreData.shared.categories?[indexPath.row] else {return UICollectionViewCell()}
        cell.configure(category)
        return cell
        }else {
            let cell:AuctionHolderCellCollectionViewCell = collectionView.dequeue(at: indexPath)
             let auctionHolder = viewModel.onSuccessGetAuctionHolders.value[indexPath.row]
            cell.setupAuctionHolder(auctionHolder)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == auctionHolderCollectionView {
            let auctionHolder = viewModel.onSuccessGetAuctionHolders.value[indexPath.row]
            let auctionHolderViewModel = AuctionHolderViewModel(holderId: "\(auctionHolder.id ?? 0)",auctionHolderImage: auctionHolder.image ?? "" ,auctionHolderName: auctionHolder.name ?? "")
            let auctionHolderViewController = AuctionHolderViewController(viewModel: auctionHolderViewModel)
            self.navigationController?.pushViewController(auctionHolderViewController, animated: true)
        }else {
            guard let categoryId = viewModel.onSuccessGetCategories.value[indexPath.row].id else {return}
            guard let categoryName = viewModel.onSuccessGetCategories.value[indexPath.row].name else {return}
            let categoryViewModel = CategoriesViewModel(id: String(categoryId),title:categoryName)
            let categoryController = CategoriesViewController(viewModel: categoryViewModel)
            navigationController?.pushViewController(categoryController, animated: true)
        }
    }
}
