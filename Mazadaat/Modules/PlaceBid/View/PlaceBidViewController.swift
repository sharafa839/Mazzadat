//
//  PlaceBidViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class PlaceBidViewController: UIViewController, HeightsBidding {
    func didBidding() {
        delegate?.didBidding()
        dismiss(animated: true)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButtton: UIButton!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var adderButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var subscribterButton: UIButton!
    @IBOutlet weak var placeBidButton: CustomButton!
    @IBOutlet weak var priceContainerView: UIView!
    var viewModel:PlaceBidViewModel
    var delegate:HeightsBidding?
    init(viewModel:PlaceBidViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelObserver()
        setupLocalize()
        setupObservables()
        
    }


    private func setupUI() {
        closeButtton.circle()
        adderButton.circle()
        subscribterButton.circle()
        priceContainerView.drawBorder(raduis: 25, borderColor: .borderColor)
        containerView.roundCorners([.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 20)
    }
    
    private func setupLocalize() {
        placeBidButton.setTitle("placeBid".localize, for: .normal)
        subTitleLabel.text = "setYourBidForThisAuction".localize
        currencyLabel.text = Localizations.SAR.localize
        titleLabel.text = "Bidding".localize
    }
    
    private func setupObservables() {
        adderButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.adder()
        }.disposed(by: viewModel.disposeBag)
        subscribterButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.subtract()
        }.disposed(by: viewModel.disposeBag)
        placeBidButton.rx.tap.subscribe { [weak self] _ in
            guard let price = Int(self?.priceTextField.text ?? "") , price > 0 else {return}
            self?.viewModel.placeBidding(price:price)
        }.disposed(by: viewModel.disposeBag)

        closeButtton.rx.tap.subscribe { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

    }
    
    private func setupViewModelObserver() {
        viewModel.priceChange.subscribe { [weak self] value in
            self?.priceTextField.text = "\(value.element ?? 0  )"
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onSuccessGetBid.subscribe { [weak self] value in
            guard let self = self else {return}
            let successResetViewModel = SuccessResetPasswordViewModel(success: false, title: "bidPlacesSuccssfully".localize, subtitle: "bidPlacesSuccssfully".localize, descrption: "bidPlacesSuccssfully".localize, type: .auction)
            let successfullyVC = SuccessResetPassowrdViewController(viewModel: successResetViewModel)
            successfullyVC.delegate = self.delegate
            self.navigationController?.pushViewController(successfullyVC, animated: true)
        }.disposed(by: viewModel.disposeBag)
    
        viewModel.onError.subscribe { [weak self] value in
            HelperK.showError(title: value.element ?? "" , subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.payEntryFee.subscribe { [weak self] value in
            self?.goTOPay(placeId: self?.viewModel.placeId ?? "")
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func goTOPay(placeId:String) {
        let planViewModel = PlanDetailsViewModel(placeId: placeId)
        let planViewController = PlanViewController(viewModel: planViewModel)
        navigationController?.pushViewController(planViewController, animated: true)
    }

}

protocol HeightsBidding {
    func didBidding()
}
