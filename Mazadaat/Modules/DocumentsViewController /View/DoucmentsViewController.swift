//
//  DoucmentsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 04/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class DoucmentsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var instructionsLabel: UILabel!
    var viewModel:DocumentViewModel
    
    init(viewModel:DocumentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
setNavigationItem(title: "Document")
        setupTableView()
        setupViewModelObservers()
        setupViewModel()
        
    }


    private func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FillDocumentCollectionViewCell.nib, forCellWithReuseIdentifier: FillDocumentCollectionViewCell.identifier)
        collectionView.register(EmptyDocumentsCollectionViewCell.nib, forCellWithReuseIdentifier: EmptyDocumentsCollectionViewCell.identifier)

        
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] _  in
            
        }.disposed(by: viewModel.disposeBag)
        
            viewModel.onSuccessGetDocument.subscribe { [weak self] _  in
                self?.collectionView.reloadData()
            }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func setupViewModel() {
        viewModel.getDocuments()
    }

}

extension DoucmentsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.onSuccessGetDocument.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let document = viewModel.onSuccessGetDocument.value[indexPath.row]
        if document.id != nil {
            let cell:FillDocumentCollectionViewCell = collectionView.dequeue(at: indexPath)
            cell.onTapChange = {[weak self] in
                self?.goToAddDocument(document: document)

            }
            cell.configure(document)
            return cell
        }else {
            let cell:EmptyDocumentsCollectionViewCell = collectionView.dequeue(at: indexPath)
            cell.configure(document)
            cell.onTapAdd = {[weak self] in
                self?.goToAddDocument(document: document)
                
            }
            return cell
        }
       
    }
    
    private func goToAddDocument(document:UploadDocuments?) {
        let addDocumentViewModel = AddDocumentViewModel(document: document)
        let addDocumentViewController = AddDocumentViewController(viewModel: addDocumentViewModel)
        navigationController?.pushViewController(addDocumentViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let document = viewModel.onSuccessGetDocument.value[indexPath.row]
        if document.id != nil {
           goToAddDocument(document: document)
        }else {
            goToAddDocument(document: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let document = viewModel.onSuccessGetDocument.value[indexPath.row]
        if document.id != nil {
            
            return CGSize(width:collectionView.frame.size.width*0.9, height: 250)
        }else {
            return CGSize(width:194, height: 161)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}
