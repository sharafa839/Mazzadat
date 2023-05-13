//
//  RequestAuctionViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 01/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class RequestAuctionViewController: UIViewController {

  
    //MARK: - IBOutlets
    @IBOutlet weak var sendButton: CustomButton!
    @IBOutlet weak var auctionDetailsTextField: UITextField!
    @IBOutlet weak var auctionDetailsLabel: UILabel!
    @IBOutlet weak var titleAuctionRequestTextField: UITextField!
    @IBOutlet weak var titleAuctionRequestLabel: UILabel!
    //MARK: - Properties
    
    //MARK: - Init
    var viewModel:RequestAuctionViewModel
    var delegate:SentRequestDelegate?
    init(viewModel:RequestAuctionViewModel) {
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
        setupObservables()
        setupLocalize()
        setupViewModelObservers()
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        sendButton.setRoundCorners(25)
        auctionDetailsTextField.drawBorder(raduis: 5, borderColor: .gray,borderWidth: Int(0.5))
        titleAuctionRequestTextField.drawBorder(raduis: 5, borderColor: .gray,borderWidth: Int(0.5))

        setNavigationItem(title: Localizations.newAuctionRequest.localize)
        
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "" , subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe { [weak self] in
            self?.delegate?.sendRequest()
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func setupLocalize() {
        titleAuctionRequestLabel.text = Localizations.auctionTitle.localize
        auctionDetailsLabel.text =  Localizations.auctionDescription.localize
        titleAuctionRequestTextField.placeholder =  Localizations.writeAuctionTitle.localize
        auctionDetailsTextField.placeholder =  Localizations.writeAuctionDescription.localize
        sendButton.setTitle(Localizations.sendRequesst.localize, for: .normal)
        [titleAuctionRequestTextField,auctionDetailsTextField].map({$0?.textAlignment = LocalizationManager.shared.getLanguage() == .Arabic ? .right : .left})

    }
    
    private func setupObservables() {
        sendButton.rx.tap.subscribe { [weak self]_ in
            
            guard let title = self?.titleAuctionRequestTextField.text , title.count > 3 else {return}
            guard let description = self?.auctionDetailsTextField.text else {return}
            self?.viewModel.addRequest(title: title, description: description)
          
        }.disposed(by: viewModel.disposeBag)

    }
    
    
    

}

protocol SentRequestDelegate {
    func sendRequest()
}
