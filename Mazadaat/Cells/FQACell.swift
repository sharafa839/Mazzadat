//
//  FQACell.swift
//  Karam
//
//  Created by musbah on 7/10/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class FQACell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionH: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tapButton: UIButton!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var lblQustion: UILabel!
    
    @IBOutlet weak var dropImg: UIImageView!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var dropView: UIView!
    private let spacing:CGFloat = 0

    var itemData: [FaqsOB]?{
        didSet{
     
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibCells()
        setUpCollection()
        // Initialization code
    }
    
    func setUpCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.collectionViewLayout = layout
        let height1 = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionH.constant = height1
        
        
    }
    
    func hideShowLesoon(hide:Bool){
        collectionView.isHidden = hide
    }
    
    override func layoutSubviews() {
        let height1 = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionH.constant = height1
        
        collectionView.layoutIfNeeded()
    }
    
    
    func registerNibCells(){
        
        let foodCell = UINib(nibName: "subAnsweCell", bundle: nil)
        
        collectionView.register(foodCell, forCellWithReuseIdentifier: "answerCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as?  subAnswerColllectionCell
        
        let obj = itemData?[indexPath.row]
        cell?.llbtitle.text = obj?.answer ?? ""
       
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:CGFloat = 1
        let spacingBetweenCells:CGFloat = 20
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: 100)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let obj = itemData?[indexPath.row]
//        self.delegate?.foodTypeData(id: obj?.SubCategory_ID ?? "")
//    }

//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//
//        let cell = collectionView.cellForItem(at: indexPath) as? ChapterDetCell
//
//        cell?.img.image = #imageLiteral(resourceName: "3444")
//        cell?.lblTime.textColor = UIColor(hexString: "5F85B2")
//        cell?.lblTime.textColor = UIColor(hexString: "5F85B2")
//        cell?.llbTitl.textColor = UIColor(hexString: "5F85B2")
//
//
//    }
    
}
