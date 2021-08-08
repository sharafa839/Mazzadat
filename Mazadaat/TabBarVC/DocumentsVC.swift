//
//  DocumentsVC.swift
//  Mazadaat
//
//  Created by macbook on 11/7/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class DocumentsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var docData:[DocOB]=[]
    
    
    @IBOutlet weak var placeHolder: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCatData()
        
        tableView.rowHeight = 120
        self.navigationController?.navigationBar.tintColor = UIColor.black
        title = "مجلد ملفاتي"
        self.tabBarController?.tabBar.isHidden = true


        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false

    }
    

    func getCatData(){
        DataClient.getDocuments(success: { (dict) in
          
            self.docData = dict
            self.tableView.reloadData()
             }, failure: { (err) in
                 
                                self.errorAlert(title: "Alert", body:  err)
                 
             })

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


extension DocumentsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if docData.count == 0 {
                   placeHolder.image = UIImage.gif(name: "animation_500_kignrnoe")
                   placeHolder.isHidden = false

                         return 0
               }else{
                   placeHolder.isHidden = true
                   return docData.count

               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell") as? docCell
        let obj = docData[indexPath.row]
        cell?.docImg.sd_setImage(with: obj.front_face?.toURL, completed: nil)
        cell?.lblTitle.text = obj.docType?.name
        cell?.lblDate.text = obj.expiry_date ?? ""
        
        
        cell?.editDoc.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        cell?.editDoc.tag = indexPath.row

        return cell!
        
    }
    
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        let obj = docData[buttonTag]
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
                 vc?.docData = obj
                 vc?.isEdit = true
        vc?.title = obj.name ?? ""
                 self.navigationController?.pushViewController(vc!, animated: true)

        
    }
    
    
    
}
