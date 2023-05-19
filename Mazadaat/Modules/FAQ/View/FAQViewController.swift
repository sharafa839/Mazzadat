//
//  FAQViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 19/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FAQViewModel
    
    init(viewModel: FAQViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getQuestions()
        viewModelSubscriber()
        setupUI()
    }

    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 5
        tableView.register(FaqTableViewCell.nib, forCellReuseIdentifier: FaqTableViewCell.identifier)
        tableView.register(FAQHeader.nib, forHeaderFooterViewReuseIdentifier: FAQHeader.identifier)
        if #available(iOS 15.0, *) {tableView.sectionHeaderTopPadding = 0}
        
    }
    
    private func setupUI() {
        setNavigationItem(title: Localizations.faqs.localize)
    }
    
    private func getQuestions(){
        viewModel.getFAQ()
    }
    
    private func viewModelSubscriber(){
        viewModel.onError.subscribe { [weak self] errorMessage in
            HelperK.showError(title: errorMessage.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onLoading.subscribe { [weak self]isLoading in
            guard let isLoading = isLoading.element else {return}
         //   isLoading ? self?.startLoading() : self?.stopLoading()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onGetFAQ.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func selectedSection(section:Int){
        tableView.beginUpdates()
        viewModel.toggleSection(section: section)
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
    
    private func selectedRow(indexPath:IndexPath){
        tableView.beginUpdates()
        viewModel.toggleRow(indexPath: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}


extension FAQViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.onGetFAQ.value.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FAQHeader.identifier) as! FAQHeader
        let sectionModel = viewModel.onGetFAQ.value[section]
        header.configure(ـ: sectionModel)
        header.onTapHeader = {[weak self] in
            self?.selectedSection(section: section)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        !(viewModel.onGetFAQ.value[section].isCollapseSection ?? false)   ? 0 :  viewModel.onGetFAQ.value[section].faqs?.count ?? 0
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FaqTableViewCell = tableView.dequeue()
        guard let question = viewModel.onGetFAQ.value[indexPath.section].faqs?[indexPath.row] else {return UITableViewCell()}
            cell.configure(with: question)
    
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow(indexPath: indexPath)
    }
    
}
