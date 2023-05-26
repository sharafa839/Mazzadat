//
//  AskGoldenBellViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 27/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionsSectionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:AuctionSectionViewModel
    var index = 0
    init(viewModel:AuctionSectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObservers()
        setupTableView()
        viewModel.getMyAuctions(myBids: true, myAuction: nil)
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = Localizations.auctions.localize
        segmentController.drawBorder(raduis: 20, borderColor: .Bronze_500)
        segmentController.setTitle(Localizations.biddings.localize, forSegmentAt: 0)
        segmentController.setTitle(Localizations.myauctions.localize, forSegmentAt: 1)
        segmentController.setTitle(Localizations.myGoldenList.localize, forSegmentAt: 2)
        segmentController.setTitleColor(.white, state: .selected)
        segmentController.setTitleColor(.textColor, state: .normal)
        segmentController.layer.borderWidth = 2
        segmentController.setTitleFont(.Cairo(15, weight: .Bold))
        segmentController.backgroundColor = .white
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { [weak self] _   in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccessGetData.subscribe { [weak self]  _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
        
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyAuctionsTableViewCell.nib, forCellReuseIdentifier: MyAuctionsTableViewCell.identifier)
        tableView.register(BiddingAuctionsTableViewCell.nib, forCellReuseIdentifier: BiddingAuctionsTableViewCell.identifier)
        tableView.register(AuctionsTableViewCell.nib, forCellReuseIdentifier: AuctionsTableViewCell.identifier)

    }
    
    private func openAuctionDetails(id:Int) {
        let auctionDetailsViewModel = AuctionsDetailsViewModel(id: "\(id)", type: "", isOfficialAuction: false, placeId: nil)
    }
    
    @IBAction func segmentAuction(_ sender: UISegmentedControl) {
        let segment = sender.selectedSegmentIndex
        switch segment {
        case 0:
            index = 0
            viewModel.getMyAuctions(myBids: true, myAuction: nil)
        case 1:
            index = 1
            viewModel.getMyAuctions(myBids: nil, myAuction: true)

        case 2:
            index = 2
            viewModel.getMyFavorite()
        default:return
        }
    }
    
}

extension AuctionsSectionViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.onSuccessGetData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch index {
        case 0:
            let cell:AuctionsTableViewCell = tableView.dequeue()
            cell.configureToBidding(with:viewModel.onSuccessGetData.value[indexPath.row])
            return cell
        case 1:
            let cell:MyAuctionsTableViewCell = tableView.dequeue()
            cell.configure(viewModel.onSuccessGetData.value[indexPath.row])
            return cell
        case 2:
            let cell:AuctionsTableViewCell = tableView.dequeue()
            cell.configureToGoldenList(with:viewModel.onSuccessGetData.value[indexPath.row])
            guard let auctionId = viewModel.onSuccessGetData.value[indexPath.row].id else {return UITableViewCell()}
            cell.onTapFavoriteButton = {[weak self] in
                self?.viewModel.toggleFavorites(auctionId: "\(auctionId)")
            }
            return cell
        default:return UITableViewCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.onSuccessGetData.value[indexPath.row].id else {return}
        openAuctionDetails(id: id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
    
}

extension UISegmentedControl {

    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
    func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        self.setTitleTextAttributes(attributes, for: state)
    }

}
