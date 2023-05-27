//
//  AuctionStortingViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionStortingViewController: UIViewController {

   
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    var viewModel:AuctionSortingViewModel
    var delegate:SortingProtocol?
    //MARK: - Init
    init(viewModel:AuctionSortingViewModel) {
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
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        closeButton.circle()
    }
    
    private func setupLocalize() {
        titleLabel.text = "sorting"
        closeButton.rx.tap.subscribe { [weak self] _  in
            self?.dismiss(animated: true)
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuctionSortingTableViewCell.nib, forCellReuseIdentifier: AuctionSortingTableViewCell.identifier)
    }
}

extension AuctionStortingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sortingDataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuctionSortingTableViewCell = tableView.dequeue()
        cell.configure(viewModel.sortingDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sort(indexPath.row)
        dismiss(animated: true, completion: nil)
    }
    
    
}

protocol SortingProtocol {
    func sort(_ by:Int)
}
