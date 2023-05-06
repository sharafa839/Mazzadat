//
//  ProfileViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, SentRequestDelegate {
    func sendRequest() {
        
    }
    

  
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var profileView: HeaderHomeView!
    @IBOutlet weak var packageView: PackageSubscribePlan!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var viewModel:ProfileViewModel
    //MARK: - Init
    init(viewModel:ProfileViewModel) {
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
        setupViews()
        setupViewModelObserver()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        containerView.setRoundCorners(20)
        packageView.setRoundCorners(5)
        packageView.setupLocalize(balance: HelperK.getMoney())
        packageView.isHidden = (CoreData.shared.personalSubscription?.isEmpty ?? false)
        
    }
    
    private func setupLocalize() {
        
    }
    
    private func setupViews() {
        headerView.configure(.profile)
        headerView.onTapNotification = { [weak self] in
            self?.openNotification()
        }
        
        profileView.onTapSetting = { [weak self] in
            self?.openControlCenter()
        }
        profileView.setupUI(view: .profile)
    }
    
    private func openControlCenter() {
        let controlCenterViewModel = ControlCenterViewModel()
        let controlCenterViewController = ControlCenterViewController(viewModel: controlCenterViewModel)
        controlCenterViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controlCenterViewController, animated: true)
    }
    
    private func openNotification() {
        let notificationsViewModel = NotificationsViewModel()
        let notificationsViewController = NotificationsViewController(viewModel: notificationsViewModel)
        notificationsViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationsViewController, animated: true)
    }
    
    private func setupViewModelObserver() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.nib, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(ProfileHeaderTableViewCell.nib, forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier)
    }
    

    
    
}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.profileDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileTableViewCell = tableView.dequeue()
        cell.configure(viewModel.profileDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.profileDataSource[indexPath.row]
        switch indexPath.row {
        case 0:
            let documentViewModel = DocumentViewModel()
            let documentViewController = DoucmentsViewController(viewModel: documentViewModel)
            documentViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(documentViewController, animated: true)
        case 1:
            return
        case 3:
            let planViewController = PlansViewController()
            planViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(planViewController, animated: true)

           
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:ProfileHeaderTableViewCell = tableView.dequeue()
        cell.didTapRequestAction = { [weak self]  in
            let requestViewModel = RequestAuctionViewModel()
            let requestViewController = RequestAuctionViewController(viewModel: requestViewModel)
            requestViewController.delegate = self
            self?.navigationController?.pushViewController(requestViewController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}
