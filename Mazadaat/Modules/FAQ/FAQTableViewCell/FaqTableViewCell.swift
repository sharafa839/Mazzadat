//
//  FaqTableViewCell.swift
//  Mazadaat
//
//  Created by Sharaf on 06/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var arrowImageView: UIStackView!
    @IBOutlet weak var splitterView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var onTap:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            setup()
        
    }
    
    func setup() {
        containerView.drawBorder(raduis: 5, borderColor: .Natural_200)
    }
    
    func configure(with:FAQElement) {
        questionLabel.text = with.question
        answerLabel.text = with.answer?.html2String
        with.isCollapseRow ?? false ?  expand() :  collapse()
    }
    
    func expand() {
        splitterView.isHidden = false
        answerLabel.isHidden = false
    }
    
    func collapse() {
        splitterView.isHidden = true
        answerLabel.isHidden = true
    }
    
    @IBAction func actionCell(_ sender: UIButton) {
        onTap?()
    }
    
    
}
