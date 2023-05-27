//
//  PersonalInformationViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PersonalInformationViewController: UIViewController, didChangeFullName, didChangeEmail, didChangePassword   , didChangePhoneNumber{
    func changePassword(password: String) {
        tableView.reloadData()
    }
   
    func changeEmail(Email: String) {
        var data = viewModel.personalInformationDataSource.value
        guard let index = data.firstIndex(where: {$0.title == Localizations.emilAddress.localize}) else {return}
        data[index].value = HelperK.getemail()
        viewModel.personalInformationDataSource.accept(data)
        
        tableView.reloadData()

    }
   
    func changePhoneNumber(number: String) {
        var data = viewModel.personalInformationDataSource.value
        guard let index = data.firstIndex(where: {$0.title == Localizations.phoneNumber.localize }) else {return}
        data[index].value = HelperK.getphone()
        viewModel.personalInformationDataSource.accept(data)
        
        tableView.reloadData()

    }
    
    func changeFullName(name: String) {
        var data = viewModel.personalInformationDataSource.value
        guard let index = data.firstIndex(where: {$0.title == Localizations.displayName.localize }) else {return}
        data[index].value = HelperK.getname()
        viewModel.requestChangeName(name: name)
        
        tableView.reloadData()
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:EditPeronalInformationViewModel
    var image:UIImage?
    var button:UIBarButtonItem?
    init(viewModel:EditPeronalInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObservers()
        setupTableView()
        setNavigationItem(title: "editProfile".localize)
    }
    
  
    func rightButtonBar() {
        
            
        button = UIBarButtonItem(title: Localizations.save.localize, style: .plain, target: self, action: #selector(updateImage))
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.tintColor = .Bronze_500
        
    }
    
    @objc
    private func updateImage() {
       
        guard let image = image?.jpegData(compressionQuality: 0.9)?.base64EncodedString() else {return}
        viewModel.updateImage(image: image )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonalInformationTableViewCell.nib, forCellReuseIdentifier: PersonalInformationTableViewCell.identifier)
        tableView.register(PersonalInformationHeader.nib, forCellReuseIdentifier: PersonalInformationHeader.identifier)
    }
    
    private func  setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] value in
            
        }.disposed(by: viewModel.disposeBag)
        viewModel.onSuccess.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)

        viewModel.didImageChange.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.personalInformationDataSource.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
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
            let alert  = UIAlertController(title: "Warning".localize, message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localize, style: .default, handler: nil))
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
            let alert  = UIAlertController(title: "Warning".localize, message: "You don't have permission to access gallery.".localize, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localize
                                          , style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
    // MARK: - Table view data source
    
extension PersonalInformationViewController:UITableViewDelegate,UITableViewDataSource{
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.personalInformationDataSource.value.count
        
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonalInformationTableViewCell = tableView.dequeue()
        cell.configure(viewModel.personalInformationDataSource.value[indexPath.row])
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : PersonalInformationHeader = tableView.dequeue()
        if let image = image {
            cell.personalImageView.image = image
        }
        
        cell.onTapEdit = { [weak self] in
            self?.imageTapped()
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = indexPath.row
        detectCell(type)
    }
    
    private func goToEditProfile(_ type:EditProfileType) {
        let editProfileViewModel = EditProfilViewModel(type: type)
        let editProfileViewController = EditFullNameViewController(viewModel: editProfileViewModel)
        switch type {
        case .name:
            editProfileViewController.fullNameDelegate = self
        case .email:
            editProfileViewController.emailDelegate = self
        case .password:
            editProfileViewController.passwordDelegate = self
        case .phone:
            editProfileViewController.phoneNumberDelegate = self
        case .verify:
            editProfileViewController.phoneNumberDelegate = self
        }
        
        present(UINavigationController(rootViewController: editProfileViewController), animated: true)
    }
    
    private func detectCell(_ tap:Int) {
        switch tap {
        case 0:
            goToEditProfile(.name)
        case 1:
            goToEditProfile(.phone)
        case 2:
            goToEditProfile(.email)
        case 3:
            goToEditProfile(.password)
        default:return
        }
    }
    
}


extension PersonalInformationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            image = pickedImage
            viewModel.didImageChange.accept(pickedImage)
            rightButtonBar()
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
}

