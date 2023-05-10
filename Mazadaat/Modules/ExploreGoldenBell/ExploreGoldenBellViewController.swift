//
//  ExploreGoldenBellViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 10/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxSwift

class ExploreGoldenBellViewController: UIViewController {
    @IBOutlet weak var shareGoldenBellButton: UIButton!
    @IBOutlet weak var GoldenBellAuctionCommunityButton: UIButton!
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var aboutGoldenBellAuctionButton: UIButton!
    
    @IBOutlet weak var instgramLabel: UILabel!

    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var youtubeLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!

    
    
    @IBOutlet weak var secondSectionView: UIView!
    @IBOutlet weak var firstSectionView: UIView!
    
    let disposBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalize()
        setupUI()
        setupObservers()
    }
    
    private func setupLocalize() {
        shareGoldenBellButton.setTitle(Localizations.share.localize, for: .normal)
        GoldenBellAuctionCommunityButton.setTitle(Localizations.GoldenBellCommuunity.localize, for: .normal)
        rate.setTitle(Localizations.rateGoldenBell.localize, for: .normal)
        aboutGoldenBellAuctionButton.setTitle(Localizations.about.localize, for: .normal)
    }
    
    private func setupUI() {
        firstSectionView.drawBorder(raduis: 10, borderColor: .borderColor)
        secondSectionView.drawBorder(raduis: 10, borderColor: .borderColor)
    }
    
    private func setupObservers() {
        shareGoldenBellButton.rx.tap.subscribe {[weak self] _ in
            
        }.disposed(by: disposBag)
        
        GoldenBellAuctionCommunityButton.rx.tap.subscribe {[weak self] _ in
            
        }.disposed(by: disposBag)
        
        rate.rx.tap.subscribe {[weak self] _ in
            
        }.disposed(by: disposBag)
        
        aboutGoldenBellAuctionButton.rx.tap.subscribe {[weak self] _ in
            let termsViewController = TermsAndConditionViewController(viewModel: TermsAndConditionViewModel(obligations: .about))
            self?.navigationController?.pushViewController(termsViewController, animated: true)
        }.disposed(by: disposBag)
        
    }
    
    @IBAction func openInstgram(_ sender: UIButton) {
        let instagram = CoreData.shared.settings?.instagram ?? ""
        HelperK.openInstagram(instgram: instagram)
    }
    @IBAction func openTwitter(_ sender: UIButton) {
       //
    }
    @IBAction func openYoutube(_ sender: UIButton) {
      //  let youtube = CoreData.shared.settings.
    }
    
    @IBAction func openFacebook(_ sender: UIButton) {
        let facebook = CoreData.shared.settings?.facebook ?? ""
        HelperK.openFacebook(facebook: facebook)
    }
    

}

enum Obligations {
    case terms,privacy,about,community
}
