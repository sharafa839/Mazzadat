//
//  EndPoints.swift
//  Mazadaat
//
//  Created by Sharaf on 05/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
enum EndPoints {
    enum Auth:String {
        case login = ""
        case register = ""
        case forgetPassword = ""
        case resetPassword = ""
        case logOut = ""
        case me = ""
        case refresh = ""
        case update = ""
        case resendVerify = ""
        case changePassword = ""
    }
    enum Notifications: String {
        case all = ""
        case send = ""
        case read = ""
        case readAll = ""
    }
    enum Transactions: String {
        case all = ""
        case myBalance = ""
        case generateCheckout = ""
        case checkPayment = ""
        case requestRefund = ""
    }
    
    enum Tickets: String {
        case all = ""
        case show = ""
        case store = ""
        case response = ""
    }
    
    enum Home:String {
        case faqs = ""
        case getNameByMobile = ""
        case subscribe = ""
        case documents = ""
        case uploadDocuments = ""
        case sendNotification
        case auctionHolder = ""
        case holderPlaces = ""
        case showHolderPlaces = ""
        case payEntreeFee = ""
    }
    
    enum Auction:String {
        case all
        case showOfficialAuction
        case show
        case toggleFavorite
        case favorite
        case addBid
    }
    
    enum Core:String {
        case install
        case advertisements
    }
}
