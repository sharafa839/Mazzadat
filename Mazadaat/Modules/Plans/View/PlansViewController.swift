//
//  PlansViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Properties
    
    //MARK: - Init
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupLocalize()
        
    }
    
    //MARK: - Methods
    private func setupLocalize() {
        titleLabel.text = "youNeedToUpgradeYourPackageToGotMoreAuctions".localize
    }
    
    private func setupUI() {
        setNavigationItem(title: Localizations.plans.localize)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlansTableViewCell.nib, forCellReuseIdentifier: PlansTableViewCell.identifier)
    }
    
  
}

extension PlansViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlansTableViewCell = tableView.dequeue()
        guard let item = CoreData.shared.subscriptions?[indexPath.row] else {return UITableViewCell()}
        cell.configure(item)
        cell.onTap = {[weak self] in
            let planDetailsViewModel = PlanDetailsViewModel(subscription: item)
            let planDetailsViewController = PlanViewController(viewModel: planDetailsViewModel)
            self?.navigationController?.pushViewController(planDetailsViewController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreData.shared.subscriptions?.count ?? 0
    }
    
    
}
