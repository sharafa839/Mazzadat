//
//  AuctionCodeView.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionCodeView: UIView, UITextFieldDelegate {
    //MARK: - IBOutelets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var titleTextFieldLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - Properties
    var onFinishTyping:((_:String?)->Void)?
    //MARK: - Init
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    private func setupUI() {
        containerView.drawBorder(raduis: 10, borderColor: .borderColor)
        codeTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason == .committed {
            guard let text = textField.text , !text.isEmpty  else {return}
            onFinishTyping?(text)
        }else {
            onFinishTyping?(nil)
        }
    }
}
