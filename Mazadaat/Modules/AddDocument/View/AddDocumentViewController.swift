//
//  AddDocumentViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBackButton: UIButton!
    @IBOutlet weak var backDoucmentIImageView: UIImageView!
    @IBOutlet weak var backContaineeChangePhoto: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var changeDocumentButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var frontDocumentImageView: UIImageView!
    @IBOutlet weak var instructionFrontLabel: UILabel!
    @IBOutlet weak var uploadButtonFront: UIButton!
    @IBOutlet weak var uploadyourDocumentFrontLabel: UILabel!
    @IBOutlet weak var frontContainer: UIView!
    @IBOutlet weak var instructionBackLabel: UILabel!
    @IBOutlet weak var uploadButtonBack: UIButton!
    @IBOutlet weak var uploadyourDocumentBackLabel: UILabel!
    @IBOutlet weak var backContainer: UIView!
    var frontImage:UIImage?
    var backImage:UIImage?
    var section:Int = 0
    var frontMultiPartItem:MultiPartItem?
    var backMultiPartItem:MultiPartItem?
    var button:UIBarButtonItem?
    var delegate:didImageUpdates?
var viewModel:AddDocumentViewModel
    init(viewModel:AddDocumentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModelObservers()
        setNavigationItem(title: "AddDocument".localize)
        //setupMultiPart()
    }
    
    private func setupMultiPart() {
        if (viewModel.pictures.value[0][0] != "") {
            let imageName = "img-\(CACurrentMediaTime()).png"
            let image = UIImageView(image: frontImage)
            image.downlodImage(str: viewModel.pictures.value[0][0])
            frontMultiPartItem = MultiPartItem(data: image.image?.jpegData(compressionQuality: 0.5) ?? Data(), fileName: imageName, mimeType: "image/png", keyName: "front_face")
        }
        
        if  (viewModel.pictures.value[1][0] != "") {
            let imageName = "img-\(CACurrentMediaTime()).png"
            let image = UIImageView(image: backImage)
            image.downlodImage(str: viewModel.pictures.value[1][0])
            backMultiPartItem = MultiPartItem(data: image.image?.jpegData(compressionQuality: 0.5) ?? Data(), fileName: imageName, mimeType: "image/png", keyName: "back_face")
        }
        
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self]  _ in
            
        }.disposed(by: viewModel.disposeBag)
        viewModel.pictures.subscribe {[weak self] model in
           
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe {[weak self] model in
            HelperK.showSuccess(title: "picUploaded", subtitle: "")
            self?.delegate?.imagesUpdates()
            self?.tableView.reloadData()
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FillAddDocumentTableViewCell.nib, forCellReuseIdentifier: FillAddDocumentTableViewCell.identifier)
        tableView.register(EmptyAddDocumentTableViewCell.nib, forCellReuseIdentifier: EmptyAddDocumentTableViewCell.identifier)
        
    }
    
    
    private func updateImage(section:Int,image:UIImage) {
        if section == 0 {
            let imageName = "img-\(CACurrentMediaTime()).png"

            frontMultiPartItem = MultiPartItem(data: image.jpegData(compressionQuality: 0.5) ?? Data(), fileName: imageName, mimeType: "image/png", keyName: "front_face")
           
        }else {
            let imageName = "img-\(CACurrentMediaTime()).png"

            backMultiPartItem = MultiPartItem(data: image.jpegData(compressionQuality: 0.5) ?? Data(), fileName: imageName, mimeType: "image/png", keyName: "back_face")
        }
      
      
    }
    
    @objc private func saveImages() {
        guard let front = frontMultiPartItem else {
            HelperK.showError(title: "fillAllData", subtitle: "")
            return
        }
        guard let back =  backMultiPartItem else {
            HelperK.showError(title: "fillAllData", subtitle: "")
            return
        }
        
        viewModel.uploadDocument(frontImage: front, bakeImage: back)
    }
    
    
    private func imageTapped() {
        let alert = UIAlertController(title: "chooseImage".localize, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera".localize, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery".localize, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: Localizations.cancel.localize, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
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
    
    func rightButtonBar() {
        
            
        button = UIBarButtonItem(title: Localizations.save.localize, style: .plain, target: self, action: #selector(saveImages))
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.tintColor = .Bronze_500
        
    }
    

}

extension AddDocumentViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.pictures.value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Localizations.frontView.localize
        }else {
            return Localizations.backView.localize
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pictures.value[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.pictures.value[indexPath.section][indexPath.row]
        if item.isEmpty || item == "" {
            let cell:EmptyAddDocumentTableViewCell = tableView.dequeue()
            cell.onTapButton = {[weak self] in
                self?.section = indexPath.section
                self?.imageTapped()
            }
        
            
            return cell
        }else {
            let cell:FillAddDocumentTableViewCell = tableView.dequeue()
            cell.configure(viewModel.pictures.value[indexPath.section][indexPath.row])
            cell.onTapChange = { [weak self] in
                self?.section = indexPath.section

                self?.imageTapped()
            }
            
            cell.onTapDelete = {[weak self] in
                self?.section = indexPath.section
          //  self?.imageTapped()
        }
            
            return cell
        }
        
    }
    
    
}




extension AddDocumentViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let ImageData = pickedImage.jpegData(compressionQuality: 0.5)
            updateImage(section: section,image: pickedImage)

            guard let imageString = ImageData?.base64EncodedString() else {return}
        
           var pic =  viewModel.pictures.value[section]
            pic = [imageString]
            var picturesAll = viewModel.pictures.value
            picturesAll[section] = pic
            viewModel.pictures.accept(picturesAll)
            rightButtonBar()
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
}
