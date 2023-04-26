//
//  AuctionsDetailsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import ImageSlideshow
class AuctionsDetailsViewController: UIViewController, HeightsBidding {
    func didBidding() {
        guard let auctionDetails = auctionDetailsModel else {return}
        biddingView.configure(auctionDetails, didBid: true)
    }
    

    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var auctionDetails: AuctionDetailesView!
    @IBOutlet weak var auctionSpecification: AuctionSpecificationView!
    @IBOutlet weak var biddingView: BiddingView!
    
    //MARK: - Properties
    var imageSource = [InputSource]()
    var delegate:HeightsBidding?
    var viewModel:AuctionsDetailsViewModel
    var auctionDetailsModel:AuctionDetailsModel?
    //MARK: - Init
    init(viewModel:AuctionsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupViewModelObserver()
        setupSlider()
        setupUI()
        setupViewObservables()
        
    }
    
    private func setupUI() {
        favoriteView.setRoundCorners(favoriteView.frame.height/2)
    }
    
    private func setupViewObservables() {
        favoriteButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.toggleFavorites()
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func setupViewModel() {
        viewModel.getAuctionsDetails()
    }
    
    private func setupViewModelObserver() {
        viewModel.auctionDetails.subscribe { [weak self] value in
            guard let auctionDetails = value.element else {return}
          

                  guard let slider = auctionDetails.media else {return}
                guard let self = self else {return}
            self.setNavigationItem(title: auctionDetails.name ?? "")
            self.favoriteButton.setImage(auctionDetails.isFavourite ?? false ? UIImage(named: "heart"):UIImage(named: "heart-add-line") , for: .normal)
            self.favoriteView.backgroundColor = auctionDetails.isFavourite ?? false ? .Bronze_500 : .lightGray
                self.imageSource.removeAll()
                  for media in slider {
                      guard let images = media.file else {return}
                          ActivityIndicatorManager.shared.hideProgressView()
                        guard let king = KingfisherSource(urlString: images) else {return}
                        self.imageSource.append(king)
                                                 
                        DispatchQueue.main.async {
                          self.imageSlider.setImageInputs(self.imageSource)

                        }
                      }
                self.configureViews(auctionDetails)
              }.disposed(by:viewModel.disposeBag)
              
        viewModel.onSuccessFavorite.subscribe { [weak self]  value in
            guard let result = value.element else {return}
            self?.favoriteButton.setImage(result.isFavourite ?? false ? UIImage(named: "heart"):UIImage(named: "heart-add-line") , for: .normal)
            self?.favoriteView.backgroundColor = result.isFavourite ?? false ? .Bronze_500 : .lightGray
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func configureViews(_ with:AuctionDetailsModel) {
        auctionDetailsModel = with
        auctionDetails.configure(with,type: viewModel.type)
        auctionSpecification.configure(with.auctionDetails ?? [], description: with.description ?? "")
        biddingView.configure(with, didBid: false)
        biddingView.didTapBiddingButton = { value in
            let placeBidViewModel = PlaceBidViewModel(id: self.viewModel.id , price: value)
            
            let placeBidViewController = PlaceBidViewController(viewModel: placeBidViewModel)
            placeBidViewController.delegate = self
            self.present(UINavigationController(rootViewController: placeBidViewController), animated: true, completion: nil)
            
        }
    }
    
     
    
    //MARK: - Methods
    
    private func setupSlider() {
        self.imageSlider.configSliderShow()
        self.imageSlider.setRoundCorners(15)
        self.imageSlider.addActionn(vc: self, action: #selector(didTab))
    }
    
    @objc func didTab()  {
        imageSlider.presentFullScreenController(from: self)
    }
    //MARK: - Methods
}
