//
//  AddTicketViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 13/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AddTicketViewController: UIViewController {

    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ticketDescriptionLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ticketTitle: UILabel!
    @IBOutlet weak var submitTicket: CustomButton!
    
   private var viewModel:TicketViewModel
    
    init(viewModel:TicketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalize()
        setupObserver()
        setNavigationItem(title: "addTicket".localize)
        setupViewModelObservers()
        
    }
    
    private func setupUI() {
        titleTextField.floating(raduis: 5)
        descriptionTextView.floating(raduis: 5)
        submitTicket.setTitle("submit".localize, for: .normal)
        [titleTextField].map({$0?.textAlignment = LocalizationManager.shared.getLanguage() == .Arabic ? .right : .left})

    }
    
    private func setupLocalize() {
        ticketDescriptionLabel.text = "ticketDescription".localize
        ticketTitle.text = "title".localize
    }
    
    private func setupObserver() {
        submitTicket.rx.tap.subscribe { [weak self] _  in
            self?.sendTicket()
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "" , subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { [weak self] value in
            //
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe{ [weak self] value in
            HelperK.showSuccess(title: "submitIssueSucces".localize, subtitle: "")
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func sendTicket() {
        guard let title = titleTextField.text , !title.isEmpty else {return}
        guard let description = descriptionTextView.text , !description.isEmpty else {return}
        viewModel.sendTicket(title: title, description: description)
    }

}
