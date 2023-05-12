//
//  AuctionsFilterViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 20/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionsFilterViewController: UIViewController {

    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var dateView: DateView!
    @IBOutlet weak var priceRangeView: PriceRangeView!
    @IBOutlet weak var auctionCodeView: AuctionCodeView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var viewModel:AuctionsFilterViewModel
    var delegate:FilterAuctionProtocol?
    init(viewModel:AuctionsFilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLocalize()
        setupViews()
        setupObservables()
    }

    private func setupUI() {
        closeButton.circle()
        applyButton.setRoundCorners(20)
        resetButton.setRoundCorners(20)

    }
    
    private func setupLocalize() {
        titleLabel.text = "auctionFilter".localize
        applyButton.setTitle("apply".localize, for: .normal)
        resetButton.setTitle("reset".localize, for: .normal)
    }
    
    private func setupViews() {
        auctionCodeView.onFinishTyping = { [weak self]value in
            guard let code = value else {return}
            self?.viewModel.code.accept(code)
        }
        
        dateView.onFinishFrom = { [weak self] value in
            guard let from = value else {return}
            self?.viewModel.dateFrom.accept(from)
        }
        
        dateView.onFinishTo = {[weak self] value in
            guard let to = value else {return}
            self?.viewModel.dateTo.accept(to)
        }
        
        priceRangeView.onFinishFrom = { [weak self]value in
            guard let from = value else {return}
            self?.viewModel.priceFrom.accept(from)
        }
        
        priceRangeView.onFinishTo = {[weak self] value in
            guard let to = value else {return}
            self?.viewModel.priceTo.accept(to)
        }
        
        
        
    }
    
    private func setupObservables() {
        closeButton.rx.tap.subscribe { [weak self]_ in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

        applyButton.rx.tap.subscribe { [weak self] value in
            self?.delegate?.didFinishFiltration(code: self?.viewModel.code.value, priceFrom: self?.viewModel.priceFrom.value, priceTo: self?.viewModel.priceTo.value, endAt: self?.viewModel.dateTo.value, endFrom: self?.viewModel.dateFrom.value)
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

        resetButton.rx.tap.subscribe { [weak self] _ in
            self?.delegate?.didFinishReset()
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

    }
}

protocol FilterAuctionProtocol {
    func didFinishFiltration( code:String? ,priceFrom:String?,priceTo:String?,endAt:String?,endFrom:String?)
    func didFinishReset()

}
