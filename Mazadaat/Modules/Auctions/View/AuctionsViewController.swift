//
//  AuctionsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 15/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionsViewController: UIViewController {

   
    //MARK: - IBOutlets
    @IBOutlet weak var burchoureLabel: UILabel!
    @IBOutlet weak var burchoureButton: UIButton!
    @IBOutlet weak var bourchureView: UIView!
    @IBOutlet weak var packageSubscription: PackageSubscribePlan!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var mapView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startingInLabel: UILabel!
    @IBOutlet weak var startingInValueLabel: UILabel!
    @IBOutlet weak var auctionDaysLabel: UILabel!
    @IBOutlet weak var auctionDaysValueLabel: UILabel!
    
    @IBOutlet weak var enttryFeeLabel: UILabel!
    @IBOutlet weak var entryFeeValueLabel: UILabel!
    //MARK: - Properties
    var viewModel:AuctionsViewModel
    //MARK: - Init
    init(viewModel:AuctionsViewModel) {
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
        setupTableView()
        setupViewModelObservables()
        setupViewModel()
        setupObservables()
        setupViews()
    }
    
    private func setupUI() {
        bourchureView.setRoundCorners(10)
        rulesView.setRoundCorners(10)
        mapView.drawBorder(raduis: 5, borderColor: .Bronze_500)
        packageSubscription.setRoundCorners(10)
    }
    
    private func setupLocalize() {
        burchoureLabel.text = "buchoure"
        rulesLabel.text = "rules"
        startingInLabel.text = "startingIn"
        enttryFeeLabel.text = "entrtyFee"
        auctionDaysLabel.text = "auctionDays"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuctionsTableViewCell.nib, forCellReuseIdentifier: AuctionsTableViewCell.identifier)
    }
    
    private func setupViewModel() {
        viewModel.getPlaces()
    }
    
    private func setupViewModelObservables() {
        viewModel.auctions.subscribe { [weak self] value in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.onError.subscribe { error in
            HelperK.showError(title: error.element ?? "", subtitle: "")
          }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { value in
//            guard let isLoading = value.element else {return}
//            if isLoading ?? false {
//                ActivityIndicatorManager.shared.showProgressView()
//            }else {
//                ActivityIndicatorManager.shared.hideProgressView()
//            }
          }.disposed(by: viewModel.disposeBag)
        viewModel.onSuccessGetAuctions.subscribe { [weak self] value in
            guard let element = value.element else {return}
            self?.setNavigationItem(title: element.place?.name ?? "")
            self?.entryFeeValueLabel.text = "\(element.place?.entryFee ?? 0)"
            guard let startingInDate = element.place?.auctionTime?.getDate() else {return}
            self?.startingInValueLabel.text = "\(startingInDate.day+"d") \(startingInDate.hour+"h") \(startingInDate.minute+"m")"
            self?.auctionDaysValueLabel.text = "\(startingInDate.day+" Days")"
        }.disposed(by: viewModel.disposeBag)

        viewModel.onSuccessFavorite.subscribe { [weak self] value in
            guard let favoriteElement = value.element else {return}
            guard var auctions = self?.viewModel.auctions.value else {return}
            guard let index = auctions.firstIndex(where: {$0.id == favoriteElement.id}) else {return}
            auctions[index].isFavourite?.toggle()
            self?.viewModel.auctions.accept(auctions)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onAuctionsEmpty.subscribe { [weak self] value in
                self?.navigationController?.popViewController(animated: true)           
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupObservables() {
        mapView.rx.tap.subscribe { [weak self] value  in
            //oopenMap
        }.disposed(by: viewModel.disposeBag)
        
        burchoureButton.rx.tap.subscribe { [weak self] _ in
            guard let bourchoure = self?.viewModel.places.value?.brochure else {return}
            guard let url = URL(string: bourchoure) else {return}
                    let _ = try! url.download(to: .documentDirectory) { url, error in
                        print(url?.path)
                    }
        }.disposed(by: viewModel.disposeBag)
        
        mapView.rx.tap.subscribe { [weak self] _ in
            
        }.disposed(by: viewModel.disposeBag)
        
        rulesButton.rx.tap.subscribe { [weak self] _ in
            guard let bourchoure = self?.viewModel.places.value?.terms else {return}
            guard let url = URL(string: bourchoure) else {return}
                    let _ = try! url.download(to: .documentDirectory) { url, error in
                        print(url?.path)
                    }
        }.disposed(by: viewModel.disposeBag)
    }
    
    
    private func setupViews() {
        packageSubscription.setupLocalize(balance: HelperK.getMoney())
        packageSubscription.onTapUpgrade = { [weak self] in
            self?.goToPlans()
           
        }
    }
    
    
    //MARK: - Methods
    private func openAuctionDetails(_ auctionId:Int) {
        let auctionDetailsViewModel = AuctionsDetailsViewModel(id: "\(auctionId)", type: viewModel.type ?? "", isOfficialAuction: viewModel.isOfficial ?? false, placeId: viewModel.placeId)
        let auctionDetailsViewController = AuctionsDetailsViewController(viewModel: auctionDetailsViewModel)
        navigationController?.pushViewController(auctionDetailsViewController, animated: true)
    }
    
    private func goToPlans() {
    let planViewController = PlansViewController()
        planViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(planViewController, animated: true)
    }
    
}

extension AuctionsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.auctions.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuctionsTableViewCell = tableView.dequeue()
        guard let id = viewModel.auctions.value[indexPath.row].id else {return UITableViewCell()}
        cell.configure(viewModel.auctions.value[indexPath.row])
        cell.onTapFavoriteButton = {
            self.viewModel.toggleFavorites(auctionId: "\(id)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let auctionId = viewModel.auctions.value[indexPath.row].id else {return}
        openAuctionDetails(auctionId)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
}
