//
//  ExploreGoldenBellViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 10/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxSwift
import StoreKit

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
        setNavigationItem(title: Localizations.exploreGoldenBell.localize)
        setupLocalize()
        setupUI()
        setupObservers()
    }
    
    private func setupLocalize() {
        shareGoldenBellButton.setTitle(Localizations.share.localize, for: .normal)
        GoldenBellAuctionCommunityButton.setTitle(Localizations.GoldenBellCommuunity.localize, for: .normal)
        rate.setTitle(Localizations.rateGoldenBell.localize, for: .normal)
        aboutGoldenBellAuctionButton.setTitle(Localizations.about.localize, for: .normal)
        instgramLabel.text = "instagram".localize
        facebookLabel.text = "facebook".localize
        twitterLabel.text = "twitter".localize
        youtubeLabel.text = "whatsapp".localize
    }
    
    @IBAction func shareApp(_ sender: UIButton) {
        let firstActivityItem = "shareMazzadat"

            // Setting url
            let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
            
            // If you want to use an image
            let image : UIImage = UIImage(named: "appIcon")!
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        firstSectionView.drawBorder(raduis: 10, borderColor: .borderColor)
        secondSectionView.drawBorder(raduis: 10, borderColor: .borderColor)
        [GoldenBellAuctionCommunityButton,rate,aboutGoldenBellAuctionButton,shareGoldenBellButton].map({$0?.contentHorizontalAlignment = LocalizationManager.shared.getLanguage() == .Arabic ? .right : .left})
    }
    
    private func setupObservers() {
      
        
        GoldenBellAuctionCommunityButton.rx.tap.subscribe {[weak self] _ in
            
        }.disposed(by: disposBag)
        
        rate.rx.tap.subscribe {[weak self] _ in
            self?.rateApp()
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
    

    func rateApp() {

        if #available(iOS 10.3, *) {

            SKStoreReviewController.requestReview()
        
        } else {

            let appID = "Your App ID on App Store"
            let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review" // (Option 2) Open App Review Page
            
            guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
            }
        }
    }

}

enum Obligations {
    case terms,privacy,about,community
}
