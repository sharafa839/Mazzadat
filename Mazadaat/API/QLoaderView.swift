//
//  QLoaderView.swift
//  QosoorApp
//
//  Created by يعرب المصطفى on 6/13/20.
//  Copyright © 2020 Ammar AlTahhan. All rights reserved.
//

import UIKit
import SwiftGifOrigin

protocol LoaderProtocol {
    func showLoader()
    func hideLoader()
    func showLoader(inViewContorller: UIViewController)
    func hideLoader(inViewContorller: UIViewController)
}
// Singleton class
class QLoaderView: UIView, LoaderProtocol {
        
    static let instance = QLoaderView()
       
    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = "animation_500_kkmcz3rp"
    var gifImage: UIImageView!
    var transparentView: UIView!


    func showLoader() {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }

    func hideLoader() {
       self.transparentView.removeFromSuperview()
    }
    
    func showLoader(inViewContorller vc: UIViewController) {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        vc.view.addSubview(self)
    }

    func hideLoader(inViewContorller vc: UIViewController) {
        self.hideLoader()
        self.removeFromSuperview()
    }

    private init(){
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(frame: frame)
        // setup transparent view
        transparentView = UIView(frame: frame)
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        
        // setup gif image
        gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 230))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: gifName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
