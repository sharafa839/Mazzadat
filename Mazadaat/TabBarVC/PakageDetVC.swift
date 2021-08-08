//
//  PakageDetVC.swift
//  Mazadaat
//
//  Created by macbook on 11/13/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit


enum RegisteredPurchase: String {

    case test

}
class PakageDetVC: UIViewController {
//    var paymentSession = Session()

    let appBundleId = "com.eleyan.goldenBell.Pakges"

    @IBOutlet weak var pakageName: UILabel!
    @IBOutlet weak var pakajePriceLabel: UILabel!
    @IBOutlet weak var transferImg: UIImageView!
    @IBOutlet weak var cashImg: UIImageView!
    @IBOutlet weak var bankChek: UIImageView!
    
    @IBOutlet weak var wireView: UIView!
    @IBOutlet weak var wireStackView: UIView!
    var paymethode = 1
    var pakegeOB: SubscribeOB?
    var defaultQueue = SKPaymentQueue()
    var myProduct : SKProduct?
    
    var transImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppData.showPayment == "1"{
            wireView.isHidden = false
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        cashImg.image = #imageLiteral(resourceName: "2203535-32")
        bankChek.image = #imageLiteral(resourceName: "2203535-24")
        title = "شراء الباقات"
        pakageName.text = pakegeOB?.name
        pakajePriceLabel.text = pakegeOB?.price ?? ""
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        transferImg.isUserInteractionEnabled = true
        transferImg.addGestureRecognizer(tapGestureRecognizer)
        
        fetchProducts()
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let alert = UIAlertController(title: "Choose back Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        // Your action
    }
    
    
    func callInAppPurchase() {
        defaultQueue = SKPaymentQueue.default()
        defaultQueue.add(self)
        requestProductInfo(productId: "productIdaddedOnitunes")
    }
    
    func purchase() {

        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.purchaseProduct(appBundleId) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()

            if case .success(let purchase) = result {
                let downloads = purchase.transaction.downloads
                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                }
                // Deliver content from server, then:
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            if let alert = self.alertForPurchaseResult(result) {
                self.showAlert(alert)
            }
        }
    }

    
    // Requesting product info from iTunes account
    func requestProductInfo(productId: String) {
        if SKPaymentQueue.canMakePayments() {
            var productID = [productId]
            let productIdentifiers = NSSet(array: productID)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as Set<NSObject> as Set<NSObject> as! Set<String>)
            productRequest.delegate = self
            productRequest.start()
            
            ActivityIndicatorManager.start()
            
        } else {
            print("No product found")
        }
    }
    
    
    func fetchProducts(){
        let rquest = SKProductsRequest(productIdentifiers: ["com.eleyan.goldenBell.Pakges"])
        rquest.delegate = self
        rquest.start()
    }
    
    
    //Requesting product payment
    func callPaymentInApp() {
//        var payment = SKPayment(product: product)
//        defaultQueue.add(payment)
        //  C.activityIndicator.startAnimating()
    }
    
    @IBAction func myBanksTapped(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BanksAccountAlertVC") as?  BanksAccountAlertVC
        vc?.modalTransitionStyle   = .crossDissolve;
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func buyPakajeTapped(_ sender: Any) {
    }
    
    
    @IBAction func cashBtn(_ sender: Any) {
        
//        purchase(.consumablePurchase, atomically: true)
//
//        callPaymentInApp()
//        cashPay()
//        guard let myProduct = myProduct else {
//            return
//        }
//        if SKPaymentQueue.canMakePayments(){
//            let payment = SKPayment(product: myProduct)
//            SKPaymentQueue.default().add(self)
//            SKPaymentQueue.default().add(payment)
//
//        }

        cashImg.image = #imageLiteral(resourceName: "2203535-32")
        bankChek.image = #imageLiteral(resourceName: "2203535-24")
        paymethode = 1
        self.wireStackView.isHidden = true
       
        
    }
    func purchase(_ purchase: RegisteredPurchase, atomically: Bool) {

        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.purchaseProduct(appBundleId + "." + purchase.rawValue, atomically: atomically) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()

            if case .success(let purchase) = result {
                let downloads = purchase.transaction.downloads
                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                }
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            if let alert = self.alertForPurchaseResult(result) {
                self.showAlert(alert)
            }
        }
    }
    @IBAction func transBtn(_ sender: Any) {
        
        cashImg.image = #imageLiteral(resourceName: "2203535-24")
        bankChek.image = #imageLiteral(resourceName: "2203535-32")
        paymethode = 2
        self.wireStackView.isHidden = false
        
        
    }
    func cashPay(){
        
        
        
//        purchase()
//        guard let myProduct = myProduct else {
//            return
//        }
//        if SKPaymentQueue.canMakePayments(){
//            let payment = SKPayment(product: myProduct)
//            SKPaymentQueue.default().add(self)
//            SKPaymentQueue.default().add(payment)
//
//        }
//                callInAppPurchase()
//
//                IAPManager.shared.purchaseProductWithId(productId: "com.eleyan.goldenBell.Pakges") { (error) -> Void in
//                  if error == nil {
//
//                    print("SUCEESS")
//                    // successful purchase!
//                  } else {
//                    // something wrong..
//                  }
//              }
        
        DataClient.payCash(subscription_id: pakegeOB?.id ?? 0,success: { (dict) in

            self.showAlertAction(title: "تنبيه", message: "تم الحفظ بنجاح")



        }, failure: { (err) in

            self.errorAlert(title: "Alert", body:  err)

        })
    }
    
    
    func bankPayment(){
        
        
        if transImg == nil {
            
            self.errorAlert(title: "تنبيه", body: "الرجاء ارفاق صورة الحوالة")
            
            return
        }
        
        DataClient.transferWirePay(img: transferImg.image!, subscription_id: pakegeOB?.id ?? 0, success: { (dict) in
            
            
            self.showAlertAction(title: "تنبيه", message: "تم الحفظ بنجاح")
            
            
        }, failure: { (err) in
            
            self.errorAlert(title: "Alert", body:  err)
            
        })
    }
    
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "tab")
            
            UIApplication.shared.windows.first?.rootViewController = newViewcontroller
            
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func buyNewPakgeTapped(_ sender: Any) {
        
        if paymethode == 1 {
            self.cashPay()
        }else{
            self.bankPayment()
        }
    }
    
    
    
}



extension PakageDetVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            
            
            
            transImg = pickedImage
            self.transferImg.image = pickedImage
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
}



extension PakageDetVC:SKProductsRequestDelegate,SKPaymentTransactionObserver{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let products = response.products.first {
            myProduct = products
            print(products.productIdentifier)
            print(products.price)
            print(products.localizedTitle)
            print(products.localizedDescription)


        }
        
//        if products.count != 0 {
//            product = products[0]
//            print("product Title = \(product.localizedTitle)")
//            print("product Description = \(product.localizedDescription)")
//            ActivityIndicatorManager.start()
//            callPaymentInApp() // finally call payment request
//        } else if response.invalidProductIdentifiers.count != 0 {
//            print("\(response.invalidProductIdentifiers.description)")
//            ActivityIndicatorManager.stop()
//        }
    }
    // delegate method to get transaction status of payment
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction: SKPaymentTransaction? in transactions as? [SKPaymentTransaction?] ?? [] {
            switch transaction?.transactionState {
            case .purchased?:
                if let transaction = transaction {
                    defaultQueue.finishTransaction(transaction)
                    print("Success")
                    print("Transaction identifier - \(transaction.transactionIdentifier)")
                    print("Transaction date - \(transaction.transactionDate)")
                    ActivityIndicatorManager.start()
                }
            case .failed?:
                if let transaction = transaction {
                    defaultQueue.finishTransaction(transaction)
                    ActivityIndicatorManager.start()
                    print("Failed")
                }
            case .restored?:
                if let transaction = transaction {
                    defaultQueue.finishTransaction(transaction)
                    print("restored")
                    ActivityIndicatorManager.start()
                }
            default:
                break
            }
        }
    }
    
    
}



extension PakageDetVC {

    func alertWithTitle(_ title: String, message: String) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    func showAlert(_ alert: UIAlertController) {
        guard self.presentedViewController != nil else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

    func alertForProductRetrievalInfo(_ result: RetrieveResults) -> UIAlertController {

        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        } else if let invalidProductId = result.invalidProductIDs.first {
            return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            return alertWithTitle("Could not retrieve product info", message: errorString)
        }
    }

    // swiftlint:disable cyclomatic_complexity
    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            print("Purchase Success: \(purchase.productId)")
            return nil
        case .error(let error):
            print("Purchase Failed: \(error)")
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: error.localizedDescription)
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
            default:
                return alertWithTitle("Purchase failed", message: (error as NSError).localizedDescription)
            }
        }
    }

    func alertForRestorePurchases(_ results: RestoreResults) -> UIAlertController {

        if results.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(results.restoreFailedPurchases)")
            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
        } else if results.restoredPurchases.count > 0 {
            print("Restore Success: \(results.restoredPurchases)")
            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
        } else {
            print("Nothing to Restore")
            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
        }
    }

    func alertForVerifyReceipt(_ result: VerifyReceiptResult) -> UIAlertController {

        switch result {
        case .success(let receipt):
            print("Verify receipt Success: \(receipt)")
            return alertWithTitle("Receipt verified", message: "Receipt verified remotely")
        case .error(let error):
            print("Verify receipt Failed: \(error)")
            switch error {
            case .noReceiptData:
                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.")
            case .networkError(let error):
                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)")
            default:
                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)")
            }
        }
    }

    func alertForVerifySubscriptions(_ result: VerifySubscriptionResult, productIds: Set<String>) -> UIAlertController {

        switch result {
        case .purchased(let expiryDate, let items):
            print("\(productIds) is valid until \(expiryDate)\n\(items)\n")
            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
        case .expired(let expiryDate, let items):
            print("\(productIds) is expired since \(expiryDate)\n\(items)\n")
            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
        case .notPurchased:
            print("\(productIds) has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
        }
    }

    func alertForVerifyPurchase(_ result: VerifyPurchaseResult, productId: String) -> UIAlertController {

        switch result {
        case .purchased:
            print("\(productId) is purchased")
            return alertWithTitle("Product is purchased", message: "Product will not expire")
        case .notPurchased:
            print("\(productId) has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
        }
    }
}


