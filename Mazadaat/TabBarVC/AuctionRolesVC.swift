//
//  AuctionRolesVC.swift
//  Mazadaat
//
//  Created by macbook on 12/2/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit



protocol getRolePageProtocol {
    func gotoRolesPAge(myData: String)
}


class AuctionRolesVC: UIViewController {
    @IBOutlet weak var lblRoles: UILabel!
    
    var delegate: getRolePageProtocol?
    var auctionData: AuctionsOB?
    var isPop = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblRoles.text = auctionData?.terms_conditions ?? ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func appRolesTapped(_ sender: Any) {
        if isPop {
            
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC") as? PrivcyPolicyVC
            vc?.isTerm = true
    //        self.present(vc, animated: true, completion: nil)
            self.present(vc!, animated: true, completion: nil)
        }else{
            self.delegate?.gotoRolesPAge(myData: "")
            self.dismiss(animated: true, completion: nil)
        }
   

    }
}
