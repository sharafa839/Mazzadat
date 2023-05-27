//
//  PriceRangeView.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PriceRangeView: UIView,UITextFieldDelegate {

    //MARK: - IBOutelets

    @IBOutlet weak var priceFromTextField: UITextField!
    @IBOutlet weak var priceToTextField: UITextField!

    @IBOutlet weak var titlePriceToTextFieldLabel: UILabel!
    @IBOutlet weak var titlePriceFromTextFieldLabel: UILabel!

    @IBOutlet weak var fromContainerView: UIView!
    @IBOutlet weak var toContainerView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - Properties
    var onFinishFrom:((_:String?)->Void)?
    var onFinishTo:((_:String?)->Void)?
    let textField = UITextField()
    //MARK: - Init
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupLocalize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    private func setupLocalize() {
        titlePriceToTextFieldLabel.text = "to".localize
        titlePriceFromTextFieldLabel.text = "from".localize
        titleLabel.text = "price".localize
        subtitleLabel.text = "price".localize
    }
    
    private func setupUI() {
        priceFromTextField.delegate = self
        priceToTextField.delegate = self
        toContainerView.drawBorder(raduis: 10, borderColor: .borderColor)
        fromContainerView.drawBorder(raduis: 10, borderColor: .borderColor)

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == priceFromTextField {
       
            guard let text = textField.text , !text.isEmpty  else {
                onFinishFrom?(nil)
                return
            }
            onFinishFrom?(text)
        }else {
            guard let text = textField.text , !text.isEmpty  else {
                onFinishTo?(nil)
                return}
            onFinishTo?(text)
        }
}
}


