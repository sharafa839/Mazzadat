//
//  OnBoardingViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 30/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import UIKit
class OnBoardingViewModel {

    let onBoardViews:[OnBoardingModel] =
    [OnBoardingModel(image: UIImage(named: "hotel (1)") ?? UIImage(),title:"Bid with Confidence - Our Guarantee to You",
                     description: "Description: Place your bids on your favorite items and win with confidence. Our auctions app offers a secure and reliable platform for bidding and purchasing items."),
     OnBoardingModel(image: UIImage(named: "hotel (1)") ?? UIImage(),title:"Bid with Confidence - Our Guarantee to You",
                      description: "Description: Place your bids on your favorite items and win with confidence. Our auctions app offers a secure and reliable platform for bidding and purchasing items.")
     ,OnBoardingModel(image: UIImage(named: "hotel (1)") ?? UIImage(),title:"Bid with Confidence - Our Guarantee to You",
                                                                                                                                                                                                                            description: "Description: Place your bids on your favorite items and win with confidence. Our auctions app offers a secure and reliable platform for bidding and purchasing items.")
    ]
    
    let currentPage = BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
}
