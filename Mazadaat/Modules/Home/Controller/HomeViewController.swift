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
    
    @IBOutlet weak var containerConstraintsLayout: NSLayoutConstraint!
    @IBOutlet weak var auctionHolderCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    //MARK: - Properties
    var imageSource = [InputSource]()
    var viewModel:HomeViewModel
    var screenSize: CGRect!
       var screenWidth: CGFloat!
       var screenHeight: CGFloat!
    var isHaveAsubscrption = !(CoreData.shared.personalSubscription?.isEmpty ?? true)

    //MARK: - Init
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit\(Self.self)")
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
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getMyBalance()
        navigationController?.isNavigationBarHidden = true
        setNavigationItem(title: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

    }
    
   
    
    func setupLayout() {
      
         var isHaveAsubscrption = !(CoreData.shared.personalSubscription?.isEmpty ?? true)
       // containerConstraintsLayout.constant = isHaveAsubscrption ? view.frame.height * 0.3 : view.frame.height * 0.22
        screenSize = UIScreen.main.bounds
        screenWidth = categoryCollectionView.bounds.width
        screenHeight =  categoryCollectionView.bounds.height
        print("screenHeight\(screenHeight), itemHeight\(screenHeight / 3)")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
        layout.itemSize = isHaveAsubscrption ?  CGSize(width: screenWidth/4, height: screenHeight/1.95) : CGSize(width: screenWidth/4, height: screenHeight/1.95)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        categoryCollectionView.collectionViewLayout = layout
        let auctionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        auctionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        auctionLayout.itemSize = CGSize(width: categoryCollectionView.frame.width / 3, height: 155)
        auctionLayout.scrollDirection = .horizontal
        auctionLayout.minimumInteritemSpacing = 0
        auctionLayout.minimumLineSpacing = 0
        auctionHolderCollectionView.collectionViewLayout = auctionLayout

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        hidesBottomBarWhenPushed = false
    }
    private func setupViewModel() {
        //viewModel.getSlider()
        viewModel.getAuctionHolders()
        viewModel.getSliders()
    }
    
    private func setupUI () {
        continerView.setRoundCorners(25)
        packageSubscribePlan.drawBorder(raduis: 10, borderColor: .Bronze_500)
       packageSubscribePlan.isHidden = (CoreData.shared.personalSubscription?.isEmpty ?? false)
        headerHomeView.setupUI(view: .home)
        packageSubscribePlan.isHidden = !HelperK.checkUserToken()
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
        
        viewModel.onAccessAuction.subscribe { [weak self] value in
            guard let element = value.element else {return}
            switch element.0 {
            case .auction:
                let id = element.1
                self?.openAuctionDetails(id: id)
            case .place :
                let id = element.1
                self?.openAuctionPlaces(id: id)
            case .subscription:
                let id = element.1
                self?.openSubscription(id: id)
            default:
               return
            }
        }.disposed(by: viewModel.disposeBag)

        viewModel.onSuccessGetMybalance.subscribe{ [weak self] value in
            guard let remaining = value.element else {return}
            HelperK.saveMoney(Type: "\(remaining)")
            self?.packageSubscribePlan.setupLocalize(balance: "\(remaining)")
          }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccesGetSlider.subscribe { [weak self] sliders in
            guard let slider = sliders.element else {return}
          guard let self = self else {return}
          self.imageSource.removeAll()
            for media in slider {
                guard let images = media.image else {return}
                   
                    ActivityIndicatorManager.shared.hideProgressView()
                  guard let king = KingfisherSource(urlString: images) else {return}
                  self.imageSource.append(king)
                                           
                  DispatchQueue.main.async {
                    self.imageSlider.setImageInputs(self.imageSource)

                  }
                }
            
        }.disposed(by:viewModel.disposeBag)
    }
    //MARK: - Methods
    
    private func setupSlider() {
        self.imageSlider.configSliderShow()
        self.imageSlider.setRoundCorners(15)
        self.imageSlider.addActionn(vc: self, action: #selector(didTab))
        
    }
    
    @objc func didTab()  {
        var current = imageSlider.currentPage
        viewModel.didTapOnSlider(index: current)
    }
    
    
    private func goToPlans() {
    let planViewController = PlansViewController()
        planViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(planViewController, animated: true)
    }
    
    private func goToNotifications() {
        let notificationViewModel =  NotificationsViewModel()
        let notificationViewController = NotificationsViewController(viewModel:notificationViewModel)
        notificationViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    private func goToProfile() {
        let profileViewModel =  ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel:profileViewModel)
        profileViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func setupViewsAction() {
        packageSubscribePlan.onTapUpgrade = {[weak self]   in
            self?.goToPlans()
        }
        
        headerHomeView.onTapNotification = { [weak self] in
            self?.goToNotifications()
        }
        
        headerHomeView.onTapSearch = { [weak self] in
            self?.goToSearch()
        }
        
    }
    
    private func goToSearch() {
        let searchViewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    private func openAuctionHolder(holderId:Int,image:String = "",name:String="") {
        let auctionHolderViewModel = AuctionHolderViewModel(holderId: "\(holderId)",auctionHolderImage: image  ,auctionHolderName: name)
        let auctionHolderViewController = AuctionHolderViewController(viewModel: auctionHolderViewModel)
        auctionHolderViewController.hidesBottomBarWhenPushed = true

        navigationController?.pushViewController(auctionHolderViewController, animated: true)

    }
    
    
    private func openAuctionDetails(id:Int,image:String = "",name:String="") {
        let auctionHolderViewModel = AuctionsDetailsViewModel(id: "\(id)", type: "", isOfficialAuction: false, placeId: nil)
        let auctionHolderViewController = AuctionsDetailsViewController(viewModel: auctionHolderViewModel)
        auctionHolderViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(auctionHolderViewController, animated: true)
    }
    
    private func openAuctionPlaces(id:Int) {
        let AuctionsViewModel = AuctionsViewModel(placeId: "\(id)")
        let auctionsViewController = AuctionsViewController(viewModel: AuctionsViewModel)
        auctionsViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(auctionsViewController, animated: true)
    }
    
    private func openSubscription(id:Int) {
        guard let index = CoreData.shared.subscriptions?.firstIndex(where: {$0.id == id}) else {return}
        guard let subscription = CoreData.shared.subscriptions?[index] else  {return}
        let planViewModel = PlanDetailsViewModel(subscription: subscription)
        let planViewController = PlanViewController(viewModel: planViewModel)
        navigationController?.pushViewController(planViewController, animated: true)
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == auctionHolderCollectionView {
            let auctionHolder = viewModel.onSuccessGetAuctionHolders.value[indexPath.row]
            openAuctionHolder(holderId: auctionHolder.id ?? 0, image: auctionHolder.image ?? "", name: auctionHolder.name ?? "")
        }else {
            guard let categoryId = viewModel.onSuccessGetCategories.value[indexPath.row].id else {return}
            guard let categoryName = viewModel.onSuccessGetCategories.value[indexPath.row].name else {return}
            let categoryViewModel = CategoriesViewModel(id: String(categoryId),title:categoryName)
            let categoryController = CategoriesViewController(viewModel: categoryViewModel)
            categoryController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(categoryController, animated: true)
        }
    }
}
