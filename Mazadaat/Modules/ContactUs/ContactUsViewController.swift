//
//  ContactUsViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 30/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit
import RxSwift
import MessageUI
class ContactUsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var phoneContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mobilePhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobilePhoneButton: UIButton!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    //MARK: - Init
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupObservables()
        setupLocalize()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        phoneContainerView.setRoundCorners(5)
        emailContainerView.setRoundCorners(5)
        setNavigationItem(title: Localizations.contactUs.localize)
        imageView.circle()
    }
    
    private func setupLocalize() {
        emailLabel.text = Localizations.emailUs.localize
        mobilePhoneLabel.text = Localizations.callUs.localize
    }
    
    private func setupObservables() {
        mobilePhoneButton.rx.tap.subscribe  { [weak self] _ in
            HelperK.openCalling(phone: CoreData.shared.settings?.mobile ?? "")
        }.disposed(by: disposeBag)
        
        emailButton.rx.tap.subscribe  { [weak self] _ in
            self?.openMail()
        }.disposed(by: disposeBag)
    }
    
    private func openMail() {
        let recipientEmail = "test@email.com"
                    let subject = "Multi client email support"
                    let body = "This code supports sending email via multiple different email apps on iOS! :)"
                    
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([""])
            mail.setSubject("")
            mail.setMessageBody("", isHTML: false)
            
            present(mail, animated: true)
            
            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: CoreData.shared.settings?.email ?? "", subject: "", body: "") {
            
        }
    }
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
               let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               
               let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
               
               if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                   return gmailUrl
               } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                   return outlookUrl
               } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                   return yahooMail
               } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                   return sparkUrl
               }
               
               return defaultUrl
           }
           
           func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
               controller.dismiss(animated: true)
           }
       

}
