//
//  MyDocumentVC.swift
//  Mazadaat
//
//  Created by macbook on 11/7/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MyDocumentVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var docImg = [#imageLiteral(resourceName: "pass"),#imageLiteral(resourceName: "credit-cardd"),#imageLiteral(resourceName: "passport"),#imageLiteral(resourceName: "driving-school")]
    var docTitle = ["بطاقة الهوية","فيزا كارت","رخصة القيادة","جواز سفر"]

    private let spacing:CGFloat = 30
    var selecTind = 0
    var docData: [DocOB] = []
    var selectInd = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "المستندات".localized

        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
                layout.minimumLineSpacing = spacing
                layout.minimumInteritemSpacing = spacing
                self.collectionView?.collectionViewLayout = layout
        self.getCatData()
        // Do any additional setup after loading the view.
    }
    
    
    func getCatData(){
         DataClient.getDocTypes(success: { (dict) in
           
             self.docData = dict
             self.collectionView.reloadData()
              }, failure: { (err) in
                  
                                 self.errorAlert(title: "Alert", body:  err)
                  
              })

     }
     
    
    @IBAction func addNewDocumentTapped(_ sender: Any) {
        
        
        
        if selectInd ==  -1 {
            
            self.toastAlert(title: "تنبيه الرجاء اختيار نوع المستند")
            return
        }
        
        let obj = docData[selectInd]
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
        vc?.title = obj.name
        vc?.id = obj.id ?? 0
        
        self.navigationController?.pushViewController(vc!, animated: true)
                  
//        switch selecTind {
//        case 0:
//  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
//  vc?.title = "بطاقة الهوية"
//  self.navigationController?.pushViewController(vc!, animated: true)
//
//         case 1:
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
//            vc?.title = "فيزا كارت"
//
//            self.navigationController?.pushViewController(vc!, animated: true)
//
//         case 2:
//
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
//            vc?.title = "رخصة القيادة"
//
//            self.navigationController?.pushViewController(vc!, animated: true)
//
//         case 3:
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? uploadVC
//            vc?.title = "جواز السفر"
//
//            self.navigationController?.pushViewController(vc!, animated: true)
//        default:
//            break
//        }
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

extension MyDocumentVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "docCell", for: indexPath) as? DocumentCell
        
        let obj = docData[indexPath.row]
        cell?.img.sd_setImage(with: obj.image?.toURL, completed: nil)
        cell?.lblTitle.text = obj.name
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DocumentCell
        
        cell?.img.image =  cell?.img.image?.imageWithColor(color1: UIColor.white)
        cell?.backV.topColor = UIColor(hexString: "FFC200")
         cell?.backV.bottomColor = UIColor(hexString: "FFC200")
        cell?.lblTitle.textColor = UIColor.white
        
        self.selectInd = indexPath.row
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DocumentCell
        
        cell?.img.image =  cell?.img.image?.imageWithColor(color1: UIColor(hexString: "686868"))
        cell?.backV.topColor = UIColor.white
        cell?.backV.bottomColor = UIColor.white
        cell?.lblTitle.textColor = UIColor.black


    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
            let numberOfItemsPerRow:CGFloat = 2
            let spacingBetweenCells:CGFloat = 30
            
            let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            
                let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
                
                    return CGSize(width: width, height: width)
             
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//          return CGSize(width: 142, height: 135)
//      }
//
    
    
    
}
