//
//  uploadVC.swift
//  Mazadaat
//
//  Created by macbook on 11/7/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SDWebImage

class uploadVC: UIViewController {

    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var forntImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var fornSelectBtn: UIButton!
    @IBOutlet weak var backSelectBtn: UIButton!
    @IBOutlet weak var backImagTitle: UILabel!
    @IBOutlet weak var fornImgTitle: UILabel!
    
    var forntImg:UIImage?
       var backImg: UIImage?
       
    var selectType = "front"
    var  selectDate = ""
    var docData: DocOB?
    var isEdit = false
    var id = 0 
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit {
            setData()
        }
        // Do any additional setup after loading the view.
    }
    
    func setData(){

      forntImageView.sd_setImage(with: docData?.front_face?.toURL, completed: nil)
       backImageView.sd_setImage(with: docData?.back_face?.toURL, completed: nil)
        
        backImg = backImageView.image
        forntImg = forntImageView?.image
        self.txtDate.text = docData?.expiry_date ?? ""
        
        self.backSelectBtn.setImage(nil, for: .normal)
        self.fornSelectBtn.setImage(nil, for: .normal)


    }
    
    @IBAction func DateTapped(_ sender: Any) {
         RPicker.selectDate(title: "Select Time", cancelText: "الغاء", datePickerMode: .date, didSelectDate: { [weak self](selectedDate) in
                   // TODO: Your implementation for date
                   self?.txtDate.text = selectedDate.toString(format: "yyyy-MM-dd")
               })
     }

    @IBAction func fronImgTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choose fornt Image", message: nil, preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
              self.openCamera()
          }))
          
          alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
              self.openGallery()
          }))
          
          alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
          
        self.selectType = "front"
          self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backImgTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose back Image", message: nil, preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
              self.openCamera()
          }))
          
          alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
              self.openGallery()
          }))
          
          alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
          self.selectType = "back"

          self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func uploadTapped(_ sender: Any) {
        
        DataClient.uploadImg(frontImg:forntImageView.image!, backImg: backImageView.image!, id: id, expiry_date: self.txtDate.text!, success: { (dict) in
              
            self.showAlertAction(title: "تنبيه", message: "تم الحفظ بنجاح")

            
            
                   }, failure: { (err) in
    
                    self.errorAlert(title: "Alert", body:  err)
                       
                   })

    }
    
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
                     
                               UIApplication.shared.windows.first?.rootViewController = newViewcontroller
                     
                                      UIApplication.shared.windows.first?.makeKeyAndVisible()
                                              }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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


extension uploadVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
     //MARK:-- ImagePicker delegate
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[.originalImage] as? UIImage {
               
       
            
            if   selectType == "front" {
                self.forntImageView.image = pickedImage
                       self.fornSelectBtn.setImage(nil, for: .normal)
            }else{
                self.backSelectBtn.setImage(nil, for: .normal)
                self.backImageView.image = pickedImage

            }

               
               self.dismiss(animated: true, completion: nil)
               
           }
       }

}
