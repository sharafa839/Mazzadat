//
//  CategoriesViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 16/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, FilterAuctionProtocol, SortingProtocol {
    func sort(_ by: Int) {
        viewModel.sorting(by: by)
    }
    
    func didFinishReset() {
        viewModel.getCategoryDetails(search: nil, code: nil, status: nil, priceFrom: nil, priceTo: nil, endAt: nil, endFrom: nil)
    }
    
    func didFinishFiltration(code: String?, priceFrom: String?, priceTo: String?, endAt: String?, endFrom: String?) {
        viewModel.getCategoryDetails(search: nil, code: code, status: nil, priceFrom: priceFrom, priceTo: priceTo, endAt: endAt, endFrom: endFrom)
        
        
    }
    

    
    //MARK: - IBOutlets
    @IBOutlet weak var packageView: PackageSubscribePlan!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    //MARK: - Properties
    var viewModel:CategoriesViewModel
    //MARK: - Init
    init(viewModel:CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAuctionsDetails()
        setupTableView()
        setupViewModelObserver()
        setupUI()
        setupLocalize()
        setupObservables()
        setupViews()
    }
    
    private func setupViews() {
        packageView.onTapUpgrade = { [weak self]   in
            self?.goToPlans()
        }
    }
    
    private func goToPlans() {
    let planViewController = PlansViewController()
        planViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(planViewController, animated: true)
    }
    
    private func getAuctionsDetails() {
        viewModel.getCategoryDetails(search: nil, code: nil, status: nil, priceFrom: nil, priceTo: nil, endAt: nil, endFrom: nil)
    }
    
    private func setupViewModelObserver() {
        viewModel.onSuccessGetAuctions.subscribe { [weak self] value in
            guard let category = value.element else {return}
            self?.resultLabel.text = "result".localize + "  " +  "\(category.count)"
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.onSuccessFavorite.subscribe { [weak self] value in
            guard let favoriteElement = value.element else {return}
            guard var auctions = self?.viewModel.onSuccessGetAuctions.value else {return}
            guard let index = auctions.firstIndex(where: {$0.id == favoriteElement.id}) else {return}
            auctions[index].isFavourite?.toggle()
            self?.viewModel.onSuccessGetAuctions.accept(auctions)
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func setupUI() {
        setNavigationItem(title: viewModel.categoryName)
        packageView.drawBorder(raduis: 10, borderColor: .Bronze_500)
        let myimage = UIImage(named: "filter-line")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(buttonTapped))
        packageView.setupLocalize(balance: HelperK.getMoney())
        packageView.isHidden = (CoreData.shared.personalSubscription?.isEmpty ?? false)

    }
    
    @objc
    private func buttonTapped() {
        let filter = AuctionsFilterViewController(viewModel: AuctionsFilterViewModel())
        filter.delegate = self
        filter.modalPresentationStyle = .popover
        self.present(filter, animated: true, completion: nil)
    }
    
    private func setupLocalize() {
        
    }
    
    private func setupObservables() {
        sortButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            let auctionSortingViewModel = AuctionSortingViewModel()
            let auctionSortingViewController = AuctionStortingViewController(viewModel: auctionSortingViewModel)
            auctionSortingViewController.delegate = self
            self.present(auctionSortingViewController, animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuctionCategoryTableViewCell.nib, forCellReuseIdentifier: AuctionCategoryTableViewCell.identifier)
    }
    //MARK: - Methods
    
}

extension CategoriesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.onSuccessGetAuctions.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AuctionCategoryTableViewCell = tableView.dequeue()
        cell.configure(viewModel.onSuccessGetAuctions.value[indexPath.row])
        guard let id = viewModel.onSuccessGetAuctions.value[indexPath.row].id else {return UITableViewCell()}
        cell.onTapFavoriteButton = {
            self.viewModel.toggleFavorites(auctionId: "\(id)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let auctionId = viewModel.onSuccessGetAuctions.value[indexPath.row].id else {return}
        
        let auctionDetailsViewModel = AuctionsDetailsViewModel(id: "\(auctionId)", type:"", isOfficialAuction: false, placeId: nil)
        let auctionDetailsViewController = AuctionsDetailsViewController(viewModel: auctionDetailsViewModel)
        self.navigationController?.pushViewController(auctionDetailsViewController, animated: true)
    }
    
}
