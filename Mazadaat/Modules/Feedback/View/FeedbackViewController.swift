//
//  FeedbackViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 01/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var generalInquery: UILabel!
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var butttonView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var sendMessageButton: CustomButton!
    @IBOutlet weak var inqueryAboutLabel: UILabel!
    //MARK: - Properties
    var viewModel:FeedbackViewModel
    //MARK: - Init
    init(viewModel:FeedbackViewModel) {
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
        if viewModel.isEmailView {
            setupIfEmail()
            setNavigationItem(title: "email")
        }else {
            setupIfFeedback()
            setNavigationItem(title: "feedback")

        }
        setupObservables()
    }
    
    private func setupUI() {
        butttonView.setRoundCorners(5)
        textView.setRoundCorners(5)
        sendMessageButton.setTitle("send", for: .normal)
        sendMessageButton.setRoundCorners(25)
    }
    
    private func setupIfFeedback() {
        titleTextView.text = "feedback"
        textView.text = "yourfeedback"
        emailView.isHidden = true
    }
    
    private func setupIfEmail() {
        titleTextView.text = "email"
        textView.text = "yourEmail"
        emailView.isHidden = true
    }
    
    private func setupObservables() {
        sendMessageButton.rx.tap.subscribe { [weak self]  in
            
        }.disposed(by: viewModel.disposeBag)

    }
    //MARK: - Methods

}
