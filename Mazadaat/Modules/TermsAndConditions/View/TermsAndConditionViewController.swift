//
//  TermsAndConditionViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 09/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class TermsAndConditionViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    var viewModel:TermsAndConditionViewModel
    init(viewModel:TermsAndConditionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupConfiguration()
    }

    private func setupConfiguration() {
        textView.setRoundCorners(10)
        if viewModel.isPrivacyAndPolicy{
            textView.text = viewModel.privacy
            setNavigationItem(title: "privacy")
        }else {
            textView.text = viewModel.terms
            setNavigationItem(title: "terms")

        }
    }

}
