//
//  PlanViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 05/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {

    @IBOutlet weak var payButton: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var planTitleLabel: UILabel!
    
    var viewModel:PlanDetailsViewModel
    var image:UIImage?
    var multipart:MultiPartItem?
    init(viewModel:PlanDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        setupViewModelObservers()
        setupObservables()
        setNavigationItem(title: "subscribe")
    }

    private func setupUI() {
        if viewModel.placeId != "" {
            planTitleLabel.text = "payToGo"
            descriptionLabel.text = "payEntreeFeeForThisPlaceToGetAllAuctionSubscription"
        }else{
            planTitleLabel.text = viewModel.subscription.name
            descriptionLabel.text = viewModel.subscription.description
        }
        
    }
    
    private func setupObservables() {
        payButton.rx.tap.subscribe { [weak self] _ in
            guard let paymentMethodId = self?.viewModel.paymentMethodId else {
                HelperK.showError(title: "youHaveToSelectPaymentMethodId", subtitle: "")
                return
            }
            
            if self?.viewModel.placeId == "" {
                guard let paymentMethodId = self?.viewModel.paymentMethodId else { return}
                self?.viewModel.uploadBankTransfer(image: self?.multipart, subscriptionId:"\( self?.viewModel.subscription.id ?? 0)", paymentMethod: "\(paymentMethodId)")
            }else {
                self?.viewModel.payEntryFees(image: self?.multipart, placeId: self?.viewModel.placeId ?? "", paymentMethod: "\(paymentMethodId)")
            }
           
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectionTableViewCell.nib, forCellReuseIdentifier: SelectionTableViewCell.identifier)
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self]  value in
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe { [weak self] _ in
            HelperK.showSuccess(title: "suubscripe successfully", subtitle: "")
        }.disposed(by: viewModel.disposeBag)

    }
    
    @objc
    private func updateImage() {
        
        let imageName = "img-\(CACurrentMediaTime()).png"
        multipart = MultiPartItem(data: image?.jpegData(compressionQuality: 0.5) ?? Data(), fileName: imageName, mimeType: "image/png", keyName:viewModel.placeId == "" ? "payment_detail":"payment_document")

       
    }
    
    private func imageTapped() {
        let alert = UIAlertController(title: "chooseImage", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openCamera()  {
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
    
    
    func openGallery() {
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
}

extension PlanViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SelectionTableViewCell = tableView.dequeue()
        cell.configure(viewModel.methods[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let id = viewModel.methods[indexPath.row].rawValue
        viewModel.paymentMethodId = id
        if id == 1 {
            imageTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}



extension PlanViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            image = pickedImage
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
}

