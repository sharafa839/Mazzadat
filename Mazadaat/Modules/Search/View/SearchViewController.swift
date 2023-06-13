//
//  SearchViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 10/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

   
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var viewModel:SearchViewModel
    //MARK: - Init
    init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem(title: Localizations.search.localize)
        setupTableView()
        setupViewModelObserver()
    }
    
    
    //MARK: - Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(AuctionCategoryTableViewCell.nib, forCellReuseIdentifier: AuctionCategoryTableViewCell.identifier)
    }
    
    private func setupViewModelObserver() {
        viewModel.onSuccessGetAuctions.subscribe { [weak self] value in
            guard let category = value.element else {return}
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
}

extension SearchViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text , text.count > 2 else {return}
        viewModel.getCategoryDetails(page: viewModel.currentPage, search: text)
    }
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height  else { return }
        if !viewModel.onLoading.value,viewModel.to ?? 0 > viewModel.currentPage {
            viewModel.currentPage += 1
            viewModel.getCategoryDetails(page: viewModel.currentPage)
        
        }
    }

    
}


