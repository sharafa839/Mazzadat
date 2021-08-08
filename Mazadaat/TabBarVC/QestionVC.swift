//
//  QestionVC.swift
//  Mazadaat
//
//  Created by macbook on 12/20/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit



import UIKit
import CollapsibleTableSectionViewController

struct Section {
    var name: String!
    var QestionData: [FaqsOB]?
    var collapsed: Bool
    
    init(name: String, QestionData: [FaqsOB], collapsed: Bool = false) {
        self.name = name
        self.QestionData = QestionData
        self.collapsed = collapsed
    }
}
class QestionVC: UIViewController {
    
    var selectedRowIndex: NSIndexPath = NSIndexPath(row: -1, section: 0)

    @IBOutlet weak var tableview: UITableView!
    var hiddenSections = Set<Int>()

    var arrayOfData : [ExpandedModel] = [] 
    let headerID = String(describing: Header.self)

    var faqobj: [QestionOB] = []
    var sections : [Section] = []
    var arrayHeader : [Int] = [] // 2 Array of header, change it as per your uses
    var oopentAt = -1

    var selctedIndex:Int?
    var ind = -1
    
    private func tableViewConfig() {
        let nib = UINib(nibName: headerID, bundle: nil)
        tableview.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        tableview.tableFooterView = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibCells()

//        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.rowHeight = UITableView.automaticDimension

        tableview.estimatedRowHeight = 44.0
//        tableview.es = 70

        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "headView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headView")

//        arrayOfData = ModelData.arrayOfData

        getCatData()
//        tableViewConfig()
        
    }
    
    
       
       func getCatData(){
           DataClient.getDataQ(success: { (dict) in
             
               self.faqobj = dict
////
               for i in dict {
                
                
                self.sections.append(Section(name: i.name ?? "", QestionData: i.faqInfo,collapsed: true ))
                
//                self.arrayOfData.append(ExpandedModel(isExpanded: false, title: i.name ?? "", array: i.faqInfo))
               }
               self.tableview.reloadData()
                }, failure: { (err) in
                    
               self.errorAlert(title: "Alert", body:  err)
                    
                    
                })

       }
       
    func registerNibCells(){
        
        let headCell = UINib(nibName: "QuestionSubSectionCell", bundle: nil)
        
        
        tableview.register(headCell, forCellReuseIdentifier: "QuestionSubSectionCell")
        
        
        tableview.delegate = self
        tableview.dataSource = self
    
        
    }
   


}



extension QestionVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].collapsed ? 0 : 2
        return sections[section].collapsed ? 0 : sections[section].QestionData!.count
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count

        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    // MARK: - Tableview methodes
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")

        header.titleLabel.text = sections[section].name
        header.titleLabel.textColor = .white

        header.arrowLabel.text = "<"
        header.setCollapsed(sections[section].collapsed)

        header.section = section
        header.delegate = self

        return header
    }
    
  
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView == tableView {
            guard let headerView = view as? UITableViewHeaderFooterView else { return }
            headerView.tintColor = .clear
        }
        
        //use any color you want here .red, .black etc
    }
    
    
    func toggleCollapse(sender: UIButton) {
        
        
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed
        
        // Reload section
        
        tableview.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionSubSectionCell") as! FQACell
        
        let obj = sections[indexPath.section].QestionData?[indexPath.row]
     
        cell.lblQustion.text = obj?.question ?? ""

        cell.itemData = sections[indexPath.section].QestionData
     
        

        cell.collectionView.isHidden = true

     
        
        return cell
        

        
        //
        //        if CourseLessons.first?.chapterData.count == 0 {
        //
        //
        //
        //
        //
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "chapterDetCell") as! ChapterDetCellTable
        //
        //
        //            let obj = otherSections[indexPath.section].chatperItems?[indexPath.row]
        //
        //
        //            cell.llbTitl.text = obj?.lessons_name_ar ?? ""
        //            cell.lblTime.textColor = UIColor(hexString: "5F85B2")
        //            cell.llbTitl.textColor = UIColor(hexString: "5F85B2")
        //
        //
        //            let videoDuration = Double(obj?.duration ?? "")
        //            let d = videoDuration?.asString(style: .positional)
        //            cell.lblTime.text = d
        //            if indexPath.row == opentAt && indexPath.section == openSection{
        //                cell.img.image = #imageLiteral(resourceName: "play_player222")
        //                cell.llbTitl.textColor = .white
        //                cell.lblTime.textColor = .white
        //            }else{
        //                if obj?.whatchData?.IS_Complete == "1"{
        //                    cell.img.image = #imageLiteral(resourceName: "play_player23")
        //                    cell.llbTitl.textColor = UIColor(hexString: "5F85B2")
        //                    cell.lblTime.textColor = UIColor(hexString: "5F85B2")
        //                }else{
        //                    cell.img.image = #imageLiteral(resourceName: "3444")
        //                    cell.llbTitl.textColor = UIColor(hexString: "5F85B2")
        //                    cell.lblTime.textColor = UIColor(hexString: "5F85B2")
        //                }
        //
        //            }
        //
        //
        //
        //
        //            return cell
        //        }else{
        //
        //
        //
        //
        //
        //
        //
        //            switch sections[indexPath.section].isOher {
        //            case true:
        //
        //
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "chapterDetCell") as! ChapterDetCellTable
        //
        //
        //                let obj = sections[indexPath.section].otherLessons[indexPath.row]
        //
        //                cell.llbTitl.text = obj.lessons_name_ar ?? ""
        //                cell.lblTime.textColor = UIColor(hexString: "5F85B2")
        //                cell.llbTitl.textColor = UIColor(hexString: "5F85B2")
        //
        //
        //                let videoDuration = Double(obj.duration ?? "")
        //                let d = videoDuration?.asString(style: .positional)
        //                cell.lblTime.text = d
        //
        //
        //
        //
        //
        //
        //                return cell
        //
        //            case false:
        //
        //
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell") as! HeaderCell
        //                let item = sections[indexPath.section].chatperItems[indexPath.row]
        //
        //                courseInd = indexPath.section
        //                chapterInd = indexPath.row
        //
        //                let indx = IndexPath(row: openIndex, section: indexPath.section)
        //                cell.titleLabel.text = item.chapter_name_ar ?? ""
        //                cell.lessonData = item.lessonsData
        //                cell.delegate = self
        //                if isNextVideo {
        //                    cell.ishear = ishearInd
        //
        //                }
        //                //        cell.detailLabel.text = item.detail
        //
        //
        //                if indexPath.row == openIndex {
        //                    cell.collectionView.isHidden = false
        //                    cell.lblPlus.text = "-"
        //                    tableView.reloadRows(at: [indx], with: .automatic)
        //                    //            cell.collectionView.updateConstraints()
        //
        //                    let height1 = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        //                    cell.collectionH.constant = height1
        //
        //                }else{
        //                    cell.collectionView.isHidden = true
        //                    cell.lblPlus.text = "+"
        //                    tableView.rowHeight   = 25
        //                }
        //
        //
        //                return cell
        //            default:
        //                break
        //            }
        //
        //
        //        }
        
    }
    
    //
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        
        self.oopentAt = buttonTag

        self.tableview.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 5.0
    //    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = sections[indexPath.section].QestionData?[indexPath.row]

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "AnswerQVC") as? AnswerQVC
      
        
        vc?.answer = obj?.answer
        vc?.qestion = obj?.question
               present(vc!, animated: true, completion: nil)
        
        //        let obj = sections[indexPath.section].chatperItems[indexPath.row]
        //
        //
        //
        //        let cell = tableView.cellForRow(at: indexPath) as? HeaderCell
        //        //
        //        //        if cell?.collectionView.isHidden == false {
        //        //            cell?.collectionView.isHidden = true
        //        //            cell?.lblPlus.text = "+"
        //        //            tableView.rowHeight   = 25
        //        //
        //        //
        //        //        }else{
        //        //            cell?.collectionView.isHidden = false
        //        //            cell?.lblPlus.text = "-"
        //        //
        //        //        }
        //        self.openIndex = indexPath.row
        //        self.currentChapterIndex = indexPath.row
        //        self.currenSectionIndex = indexPath.section
        //
        //        self.postionVideoDelegate?.sendCurrentVideoPostion(courseInd: indexPath.section, chapterInd: indexPath.row, lessonInd: self.currentLessonIndex, isOtherVideos: false)
        //
        //        tableView.reloadData()
        
    }
    
    
}




extension QestionVC: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        
        let collapsed = !sections[section].collapsed
              
          // Toggle collapse
          sections[section].collapsed = collapsed
//          header.setCollapsed(collapsed)
          
          // Reload the whole section
          tableview.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
//
//        func indexPathsForSection() -> [IndexPath] {
//            var indexPaths = [IndexPath]()
//
//
//        let collapsed = !sections[section].collapsed
//
//        // Toggle collapse
//        sections[section].collapsed = collapsed
//        header.setCollapsned(collapsed)
//
//        for i in 0..<sections.count {
//
//            if i != section {
//                sections[i].collapsed = true
//
//            }
//        }
//        //        currenSectionIndex = section
//        //        AppData.CourseIndex = section
//        //        AppData.chapterCount = CourseLessons[section].chapterData.count
//        tableview.reloadData()
//
//    }
        
    }
    
}


extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
