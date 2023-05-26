//
//  NotificationsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

  
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //MARK: - Properties
    var viewModel:NotificationsViewModel
    //MARK: - Init
    init(viewModel:NotificationsViewModel) {
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
        setupTableView()
        setupViewModelObserver()
        setupViewModel()
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        setNavigationItem(title: "Notification")
        segmentControl.setTitle(Localizations.biddings.localize, forSegmentAt: 0)
        segmentControl.setTitle(Localizations.myauctions.localize, forSegmentAt: 1)
        segmentControl.setTitleColor(.textColor,state: .selected)
        segmentControl.setTitleColor(.white,state: .normal)
        segmentControl.setTitleFont(.Cairo(14,weight: .Bold))
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)
    }
    
    private func setupViewModel() {
        viewModel.getNotifications()
    }
    
    private func setupViewModelObserver() {
        viewModel.onSuccessGetNotification.subscribe { [weak self] value in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] value in
            
        }.disposed(by: viewModel.disposeBag)
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.getBidding()
        }else {
            viewModel.getMyAuctions()
        }
    }
}

extension NotificationsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.onSuccessGetNotification.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = tableView.dequeue()
        let notification = viewModel.onSuccessGetNotification.value[indexPath.row]
        cell.configure(notification)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        161
    }
    
}

