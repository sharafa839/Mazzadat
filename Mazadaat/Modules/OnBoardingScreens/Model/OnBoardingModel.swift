//
//  OnBoardingModel.swift
//  Mazadaat
//
//  Created by Sharaf on 30/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import UIKit
struct OnBoardingModel {
    let image: UIImage
    let title: String
    let description: String
    
    
    init(image:UIImage,title:String,description:String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
