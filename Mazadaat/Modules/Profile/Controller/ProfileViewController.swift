//
//  ProfileViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 25/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  
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
        packageView.isHidden = (CoreData.shared.personalSubscription?.isEmpty ?? false)
        
    }
    
    private func setupLocalize() {
        
    }
    
    private func setupViews() {
        headerView.configure(.profile)
        profileView.setupUI(view: .profile)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:ProfileHeaderTableViewCell = tableView.dequeue()
        cell.didTapRequestAction = {
            print("Connnt")
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
