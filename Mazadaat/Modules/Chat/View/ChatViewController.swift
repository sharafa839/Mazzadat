//
//  ChatViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 13/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:ChatViewModel
    init(viewModel:ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupObservables()
        setupViewModelObservers()
        viewModel.getMessages()
        setNavigationItem(title: viewModel.name ?? Localizations.chat.localize)
    }


    private func setupObservables() {
        sendButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}

            guard let text = self.textField.text ,
                  !text.isEmpty else {return}
            let date = Date()
            let message = Message(senderType: "user", date: date.toString(format: "yyyy-mm-dd"), message: text, name: HelperK.getname())
            
            viewModel.sendMessageToBackend(message: message)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MCell.nib, forCellReuseIdentifier: MCell.identifier)
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self]  _ in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.messages.subscribe { [weak self] _ in
            
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
    }
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MCell = tableView.dequeue()
        cell.configure(message: viewModel.messages.value[indexPath.row])
        return cell
    }
    
   
    
}
