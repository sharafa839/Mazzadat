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
        case login = "api/auth/login"
        case register = "api/auth/signup"
        case forgetPassword = "api/auth/forget_password"
        case resetPassword = "api/auth/reset_password"
        case logOut = "api/auth/logout"
        case me = "api/auth/me"
        case refresh = "api/auth/refresh"
        case update = "api/auth/update"
        case resendVerify = "api/auth/resend_verify"
        case changePassword = "api/auth/change_password"
        case verify = "api/auth/verify"
        case notificationSetting = "api/auth/update_setting"
    }
    
    enum Notifications: String {
        case all = "api/notifications"
        case send = "api/notifications/send"
        case read = "api/notifications/read"
        case readAll = "api/notifications/read/all"
    }
    
    enum Transactions: String {
        case all = "api/transactions/"
        case myBalance = "api/transactions/my_balance"
        case generateCheckout = "api/transactions/generate_checkout"
        case checkPayment = "api/transactions/check_payment"
        case requestRefund = "api/transactions/request_refund"
    }
    
    enum Tickets: String {
        case all = "api/tickets"
        case show = "api/tickets/show?ticket_id"
        case store = "api/tickets/store"
        case response = "api/tickets/response"
        case changeName = "api/tickets/change-name"
    }
    
    enum Home:String {
        case faqs = "api/home/faqs"
        case getNameByMobile = "api/home/get_name_by_mobile/"
        case subscribe = "api/home/subscribe"
        case documents = "api/home/documents"
        case uploadDocuments = "api/home/upload_document"
        case sendNotification = "api/home/send_notification"
        case auctionHolder = "api/home/holders"
        case holderPlaces = "api/home/holder_places"
        case showHolderPlaces = "api/home/show_holder_place"
        case payEntreeFee = "api/home/entry_fee"
        case slider = "api/home/sliders"
        case removeDocument = "api/home/remove_document"
        case addAdvertisementRequest = "api/home/add_advertisement"
        case addFeedback = "api/home/add_feedback"
        case sendMessage = "api/home/send-message"
    }
    
    enum Auction:String {
        case all = "api/auctions"
        case showOfficialAuction = "api/auctions/official_auction"
        case show = "api/auctions/show"
        case toggleFavorite = "api/auctions/toggle_favourite"
        case favorite = "api/auctions/favourites"
        case addBid = "api/auctions/add_bid"
        case advertisement = "api/home/sliders"
    }
    
    enum Core:String {
        case install = "api/install"
        case advertisements  = "api/auctions"
        case index = "api/advertisement/index/"
    }
}
