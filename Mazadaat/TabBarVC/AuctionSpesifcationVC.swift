//
//  AuctionSpesifcationVC.swift
//  Mazadaat
//
//  Created by macbook on 12/5/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class AuctionSpesifcationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var auctionSp: [AuctionDetialsOB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dimissTapped(_ sender: Any) {
        
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

extension AuctionSpesifcationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auctionSp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "auctionDetCell") as? auctionDetCell
        let obj = auctionSp[indexPath.row]
        
        cell?.lblTitle.text = obj.name
        cell?.lblDetials.text = obj.value
        return cell!
    }
    
    
    
    
    
}




class auctionDetCell: UITableViewCell{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetials: UILabel!
    
    
}
