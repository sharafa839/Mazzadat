//
//  DateView.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class DateView: UIView {

    @IBOutlet weak var fromContainerView: UIView!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var toContainerView: UIView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - Properties
    var onFinishFrom:((_:String?)->Void)?
    var onFinishTo:((_:String?)->Void)?
    //MARK: - Init
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        toContainerView.drawBorder(raduis: 10, borderColor: .borderColor)
        fromContainerView.drawBorder(raduis: 10, borderColor: .borderColor)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    @IBAction func toDatePickerAction(_ sender: UIDatePicker) {
        let date = sender.date
       
        onFinishTo?(date.toArString())
    }
    @IBAction func fromDatePickerAction(_ sender: UIDatePicker) {
        let date = sender.date
        onFinishFrom?(date.toArString())

    }
    
}
