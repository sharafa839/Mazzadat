//
//  TicketViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 01/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var viewModel:TicketViewModel
    var index = 0
   
    //MARK: - Init
    init(viewModel:TicketViewModel) {
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
        setupViewModelObservers()
        setupTableView()
        setupViewModel()
    }
    
    
    //MARK: - Methods

    
    private func setupLocalize() {
        
    }

    private func setupViewModel() {
        viewModel.getTickets()
    }

    private func setupUI() {
        setNavigationItem(title: Localizations.myTickets.localize)
        segmentController.drawBorder(raduis: 20, borderColor: .Bronze_500)
        segmentController.setTitle("all".localize, forSegmentAt: 0)
        segmentController.setTitle("running".localize, forSegmentAt: 1)
        segmentController.setTitle("closed".localize, forSegmentAt: 2)
        segmentController.setTitleColor(.white, state: .selected)
        segmentController.setTitleColor(.textColor, state: .normal)
        segmentController.layer.borderWidth = 2
        segmentController.setTitleFont(.Cairo(18, weight: .Bold))
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
        tableView.register(TicketTableViewCell.nib, forCellReuseIdentifier: TicketTableViewCell.identifier)

    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        tableView.reloadData()
    }
}

extension TicketViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 0 {
            return    viewModel.onSuccessGetData.value.count
        }else if index == 1 {
            return   viewModel.onSuccessRunning.value.count
        }else {
            return  viewModel.onSuccessClose.value.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TicketTableViewCell = tableView.dequeue()
        if index == 0 {
            cell.configure(viewModel.onSuccessGetData.value[indexPath.row])
        }else if index == 1 {
            cell.configure(viewModel.onSuccessRunning.value[indexPath.row])
        }else {
            cell.configure(viewModel.onSuccessClose.value[indexPath.row])
        }
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewModel = ChatViewModel(ticketId: "\(viewModel.onSuccessGetData.value[indexPath.row].id ?? 0)")
        let chatViewController = ChatViewController(viewModel: chatViewModel)
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
}
