//
//  OnBoardingScreensViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 29/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
class OnBoardingScreensViewController: UIViewController {
    //MARK: - IBOutlets

    @IBOutlet weak var anotherView: UICollectionView!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    @IBOutlet weak var paginationCollectionView: UICollectionView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    

    //MARK: - Properties
    private var viewModel:OnBoardingViewModel
    //MARK: - Init
    init(viewModel:OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCells()
        setupCollectionView()
        setupObservables()
        setupViewModelObserver()
    }

    private func setupUI() {
        nextButton.circle()
        backButton.circle()
        languageButton.drawBorder(raduis: 5, borderColor: .black)
        languageButton.setTitle("عربي", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Methods
    private func setupCollectionView() {
        onBoardingCollectionView.delegate = self
        onBoardingCollectionView.dataSource = self
        paginationCollectionView.delegate = self
        paginationCollectionView.dataSource = self
    }
    
    private func setupCells() {
        onBoardingCollectionView.register(nib: OnBoardingCollectionViewCell.self)
        paginationCollectionView.register(nib: PagingCollectionViewCell.self)
    }
    
    private func setupViewModelObserver() {
        viewModel.currentPage.subscribe { [weak self] value in
            self?.paginationCollectionView.reloadData()
            self?.configureUI(currentPage: value.element ?? 0)
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupObservables() {
      
        
        backButton.rx.tap.subscribe { [weak self] _ in
            self?.getBackPage(currentPage: self?.viewModel.currentPage.value ?? 0)
        }.disposed(by: viewModel.disposeBag)
        
        nextButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.currentPage.value != 2 ?
            self?.getNextPage(currentPage: self?.viewModel.currentPage.value ?? 0) :
            self?.navigateToLogin()
        }.disposed(by: viewModel.disposeBag)
        
        languageButton.rx.tap.subscribe { [weak self] _ in
            self?.changeLanguage()
        }.disposed(by: viewModel.disposeBag)

       
    }
    
    private func changeLanguage() {
        
    }
    
    private func navigateToLogin() {
        HelperK.saveFristTime(token: true)
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        appDelegate.coordinator.setRoot(UINavigationController(rootViewController:loginViewController))
       //r navigationController?.pushViewController(loginViewController, animated: true)

        print("login")
    }
    
    private func getNextPage(currentPage:Int) {
        let page = currentPage + 1
        viewModel.currentPage.accept(page)
        let indexPath = IndexPath(row:page , section: 0)
        onBoardingCollectionView.isPagingEnabled = false
        onBoardingCollectionView.tryScroll(to: indexPath,position: .centeredHorizontally)
        onBoardingCollectionView.isPagingEnabled = true
        
    }
    
    private func getBackPage(currentPage:Int) {
        let page = currentPage - 1
        viewModel.currentPage.accept(page)
        let indexPath = IndexPath(row:page, section: 0)
        onBoardingCollectionView.tryScroll(to: indexPath,position: .centeredVertically)
    }
    
    private func configureUI(currentPage:Int) {
        
        backButton.isHidden = currentPage == 0   ? true : false
        paginationCollectionView.isHidden = currentPage == 2 ? true : false
        anotherView.isHidden = currentPage == 2 ? true : false
        
        if currentPage == 2 {
            nextButton.setTitle("next".localize, for: .normal)
            nextButton.setImage(nil, for: .normal)
        }else {
            nextButton.setTitle(nil, for: .normal)
            nextButton.setImage(UIImage(named: "arrowRight"), for: .normal)

        }
    }

    
}

extension OnBoardingScreensViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == onBoardingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
            cell.configure(items: viewModel.onBoardViews[indexPath.row])
            return cell
        }else {
            let cell:PagingCollectionViewCell = collectionView.dequeue(at: indexPath)
            if viewModel.currentPage.value == indexPath.row {
                cell.currentView.backgroundColor = .Bronze_500
            }else{
                cell.currentView.backgroundColor = .Bronze_50
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == onBoardingCollectionView {
            return CGSize(width: onBoardingCollectionView.frame.width, height: onBoardingCollectionView.frame.height)
        }else{
            if viewModel.currentPage.value == indexPath.row {
                
                return CGSize(width: 32, height: 6)
            }else{
                return CGSize(width: 12, height: 6)
            }
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = onBoardingCollectionView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        viewModel.currentPage.accept(currentPage)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == onBoardingCollectionView {
            return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        }else{
            return UIEdgeInsets(top: 5, left: (paginationCollectionView.frame.width/2) - 40, bottom: 5, right:  (paginationCollectionView.frame.width/2) - 20)
        }
        
    }
}

extension UIView {
    func circle() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

extension UICollectionView {
    
    func register<Cell:UICollectionViewCell>(nib cell : Cell.Type){
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)

    }
    
    
    func dequeue<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
        let id = Cell.identifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? Cell
        else { fatalError("Cannot dequeue cell with identifier '\(id)'") }
        return cell
    }
    
        
        func tryScroll(to indexPath: IndexPath, position: ScrollPosition = .top) {
            if indexPath.section < numberOfSections,
               indexPath.item < numberOfItems(inSection: indexPath.section) {
                scrollToItem(at: indexPath, at: position, animated: true)
            }
        }
        
        func trySelectItem(at indexPath: IndexPath?, animated: Bool = true, scrollPosition: UICollectionView.ScrollPosition) {
            guard let indexPath = indexPath else { return }
            if indexPath.section < numberOfSections,
               indexPath.item < numberOfItems(inSection: indexPath.section) {
                selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
            }
        }
    
}
