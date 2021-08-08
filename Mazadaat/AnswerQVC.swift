//
//  AnswerQVC.swift
//  Mazadaat
//
//  Created by macbook on 01/06/2021.
//  Copyright © 2021 macbook. All rights reserved.
//

import UIKit

class AnswerQVC: UIViewController {

    @IBOutlet weak var txtAnswer: UITextView!
    @IBOutlet weak var lblQ: UILabel!
    
    var qestion: String?
    var answer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblQ.text = qestion
        
        self.txtAnswer.attributedText = answer?.htmlToAttributedString
        
        if AppData.lang == "en"{
            self.txtAnswer.textAlignment = .left

        }else{
            self.txtAnswer.textAlignment = .right

        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


