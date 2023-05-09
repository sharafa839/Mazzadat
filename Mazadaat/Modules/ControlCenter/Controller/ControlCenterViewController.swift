//
//  ControlCenterViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 28/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class ControlCenterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel:ControlCenterViewModel
    
    init(viewModel:ControlCenterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        setupViewModelObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupUI() {
        setNavigationItem(title: "profile")
    }
    
    private func setupViewModelObservers() {
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { [weak self] _ in
            
            
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccess.subscribe { [weak self] _ in
            HelperK.deletUserDefaults()
            self?.setRoot(LoginViewController(viewModel: LoginViewModel()), withNavigation: true, animated: true)
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ControlCentetrFooter.nib, forCellReuseIdentifier: ControlCentetrFooter.identifier)
        tableView.register(ControlCenterHeader.nib, forCellReuseIdentifier: ControlCenterHeader.identifier)
        tableView.register(ControlCenterTableViewCell.nib, forCellReuseIdentifier: ControlCenterTableViewCell.identifier)
    }
    
    private func openEditPersonalInformation() {
        let editPersonsalInformationViewModel = EditPeronalInformationViewModel()
        let personalInformationViewController = PersonalInformationViewController(viewModel: editPersonsalInformationViewModel)
        navigationController?.pushViewController(personalInformationViewController, animated: true)
    }
}
    // MARK: - Table view data source
extension ControlCenterViewController:UITableViewDelegate,UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.editProfileDataSource.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.editProfileDataSource[section].count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ControlCenterTableViewCell = tableView.dequeue()
        let item = viewModel.editProfileDataSource[indexPath.section][indexPath.row]
        cell.configure(item)
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header: ControlCenterHeader = tableView.dequeue()
            return header
        }else {
            return nil
        }
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let footer: ControlCentetrFooter = tableView.dequeue()
            footer.onTapLogout = { [weak self] in
                self?.viewModel.logout()
            }
            return footer
        }else {
            return nil
        }
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150
        }else {
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 70
        }else {
            return 16
        }
    }
    

    func openSetting() {
        let setting = SettingViewController(viewModel: SettingViewModel())
    self.navigationController?.pushViewController(setting, animated: true)
    }
    func openContactUs() {
        let contactUs = ContactUsViewController()
        self.navigationController?.pushViewController(contactUs, animated: true)
    }
   

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        switch section {
        case 0 :
            switch row {
            case 0:
                openEditPersonalInformation()
            case 1:
                openSetting()
            default:
                return
            }
        case 1:
            switch row {
            case 0:
                openContactUs()
            case 1:
                return
            case 2:
                return
            default:
                return
            }
        case 2:
            switch row {
            case 0:
                let termsViewModel = TermsAndConditionViewModel(isPrivacyAndPolicy: false)
                let termsViewController = TermsAndConditionViewController(viewModel: termsViewModel)
                navigationController?.pushViewController(termsViewController, animated: true)
            case 1:
                let termsViewModel = TermsAndConditionViewModel(isPrivacyAndPolicy: true)
                let termsViewController = TermsAndConditionViewController(viewModel: termsViewModel)
                navigationController?.pushViewController(termsViewController, animated: true)
                
            default:
                return
            }
        default:
            return
        }
    }
}

