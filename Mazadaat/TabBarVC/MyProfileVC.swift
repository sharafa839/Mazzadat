//
//  MyProfileVC.swift
//  Mazadaat
//
//  Created by macbook on 10/20/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var profileUser: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    var userData: userOB?
    
    @IBOutlet weak var personalView: UIView!
    
    @IBOutlet weak var pakagesView: UIView!
    @IBOutlet weak var docView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var contactUs: UIView!
    
    @IBOutlet weak var login: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        if AppData.isLogin == true {
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
              profileUser.isUserInteractionEnabled = true
              profileUser.addGestureRecognizer(tapGestureRecognizer)
            
            
            privacyView.isHidden = true
            login.isHidden = true
            contactUs.isHidden = true
            
            personalView.isHidden = false
            passwordView.isHidden = false
            docView.isHidden = false
            pakagesView.isHidden = false
            
            
        }else{
            
            personalView.isHidden = true
            passwordView.isHidden = true
            docView.isHidden = true
            pakagesView.isHidden = true
            
    
            privacyView.isHidden = false
            login.isHidden = false
            contactUs.isHidden = false

        }
  
        // Do any additional setup after loading the view.
    }
    


    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let alert = UIAlertController(title: "Choose fornt Image", message: nil, preferredStyle: .actionSheet)
               alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                   self.openCamera()
               }))
               
               alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                   self.openGallery()
               }))
               
               alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
               
               self.present(alert, animated: true, completion: nil)
        
        
        
        // Your action
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NaveBarManager.navgationBar.hideNaveBar(vc: self)

        if AppData.isLogin == true {
            getUser()
            tabBarController?.tabBar.isHidden = false
        }
        

    }
    func updateProfile(){
        
        DataClient.uploadProfileImg(img: profileUser.image!, success: { (dict) in
                    
            self.getUser()
                  
                  
                         }, failure: { (err) in
          
                          self.errorAlert(title: "Alert", body:  err)
                             
                         })
    }
    
    
    
    @IBAction func privcyButton(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "PrivcyPolicyVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func contactButton(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
                            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "authTab")
        UIApplication.shared.windows.first?.rootViewController = newViewcontroller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    
    func getUser(){
           DataClient.getMyProfile(success: { (dict) in
             
            self.userData = dict
            if let userImg = dict.avatar {
                self.profileUser.sd_setImage(with: userImg.toURL, placeholderImage: #imageLiteral(resourceName: "iconfinder_Instagram_UI-18_2315582"), completed: nil)
            }
            self.userEmail.text = dict.email ?? ""
            self.userName.text = dict.name ?? ""
            AppData.userImg = dict.avatar ?? ""
            AppData.username = dict.name ?? ""
            
                }, failure: { (err) in
                    
                self.errorAlert(title: "Alert", body:  err)
                    
                })

       }

    
    @IBAction func infoTapped(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
                      let vc = story.instantiateViewController(withIdentifier: "MyInfoVC") as? MyInfoVC
        
        
        vc?.userObj = userData
        self.navigationController?.pushViewController(vc!, animated: true)
            

        
    }
    @IBAction func passTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Auth", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "RestPAsswordVC")
        vc.title = "تغير كلمة المرور"
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func saveDocTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle:nil)
                  let vc = story.instantiateViewController(withIdentifier: "DocumentsVC")
        
        
                  self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func myPakajesTapped(_ sender: Any) {

                  let story = UIStoryboard(name: "Main", bundle:nil)
                     let vc = story.instantiateViewController(withIdentifier: "PakagesVC")
                     self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}





extension MyProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    
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
               
            profileUser.image = pickedImage

               self.dismiss(animated: true, completion: nil)
               updateProfile()

           }
       }

}
