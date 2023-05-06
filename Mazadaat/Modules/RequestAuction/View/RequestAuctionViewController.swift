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
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        sendButton.setRoundCorners(25)
        auctionDetailsTextField.drawBorder(raduis: 5, borderColor: .gray,borderWidth: Int(0.5))
        titleAuctionRequestTextField.drawBorder(raduis: 5, borderColor: .gray,borderWidth: Int(0.5))

        setNavigationItem(title: "newAuctionRequest")
        
    }
    
    private func setupObservables() {
        sendButton.rx.tap.subscribe { [weak self]_ in
            self?.delegate?.sendRequest()
        }.disposed(by: viewModel.disposeBag)

    }

}

protocol SentRequestDelegate {
    func sendRequest()
}
