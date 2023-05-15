//
//  CoreModel.swift
//  Mazadaat
//
//  Created by Sharaf on 08/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation


// MARK: - DataClass
struct CoreAppModel:Codable {
    var settings: Settings?
    var subscriptions: [Subscription]?
    var bankAccounts: [BankAccount]?
    var categories: [Category]?
    var countries: [Country]?
    var documentsTypes: [Category]?
    var essentials: Essentials?
    enum CodingKeys: String, CodingKey {
           case subscriptions = "Subscriptions"
           case essentials = "Essentials"
           case settings = "Settings"
           case countries = "Countries"
           case categories = "Categories"
           case documentsTypes = "DocumentsTypes"
           case bankAccounts = "BankAccounts"
       }
}

// MARK: - BankAccount
struct BankAccount:Codable {
    var id: Int?
    var bankName, accountName, accountNumber, accountIban: String?
    enum CodingKeys: String, CodingKey {
           case id
           case bankName = "bank_name"
           case accountName = "account_name"
           case accountNumber = "account_number"
           case accountIban = "account_iban"
       }
}

// MARK: - Category
struct Category:Codable {
    var id: Int?
    var name: String?
    var image: String?
    var auctionCount: Int?
    enum CodingKeys: String, CodingKey {
            case id
            case auctionCount = "auction_count"
            case name, image
        }
}

// MARK: - Country
struct Country:Codable {
    var id: Int?
    var name: String?
    var cities: [City]?
    enum CodingKeys: String, CodingKey {
            case id, name
            case cities = "Cities"
        }
}

// MARK: - City
struct City:Codable {
    var id: Int?
    var name: String?
}

// MARK: - Essentials
struct Essentials :Codable{
    var ticketsStatus: TicketsStatus?
    var notificationType: NotificationType?
    var senderType: SenderType?
    var verificationType: VerificationType?
    var subscriptionStatuses: SubscriptionStatuses?
    var paymentMethod: PaymentMethod?
    var transactionStatus: TransactionStatus?
    var transactionTypes: TransactionTypes?
    var auctionStatuses: AuctionStatuses?
    enum CodingKeys: String, CodingKey {
            case subscriptionStatuses = "SubscriptionStatuses"
            case transactionStatus = "TransactionStatus"
            case verificationType = "VerificationType"
            case paymentMethod = "PaymentMethod"
            case notificationType = "NotificationType"
            case transactionTypes = "TransactionTypes"
            case ticketsStatus = "TicketsStatus"
            case senderType = "SenderType"
            case auctionStatuses = "AuctionStatuses"
        }
}

// MARK: - AuctionStatuses
struct AuctionStatuses :Codable{
    var waitingStart, bidingTime, waitingSupplierApproval, waitingCustomerPayment: Int?
    var finished, supplierRejected, customerCanceled, finishedWithoutAnyBid: Int?
    enum CodingKeys: String, CodingKey {
           case waitingSupplierApproval = "WaitingSupplierApproval"
           case customerCanceled = "CustomerCanceled"
           case finishedWithoutAnyBid = "FinishedWithoutAnyBid"
           case waitingCustomerPayment = "WaitingCustomerPayment"
           case supplierRejected = "SupplierRejected"
           case finished = "Finished"
           case waitingStart = "WaitingStart"
           case bidingTime = "BidingTime"
       }
}

enum AuctionStatus:Int {
    case waitingStart = 0, bidingTime, waitingSupplierApproval, waitingCustomerPayment,finished, supplierRejected, customerCanceled, finishedWithoutAnyBid
    var status:String {
        switch self {
        case .waitingStart:
            return "waitingStart"
        case .bidingTime:
            return "bidingTime"
        case .waitingSupplierApproval:
            return "waitingSupplierApproval".localize
        case .waitingCustomerPayment:
            return "waitingCustomerPayment"
        case .finished:
            return "finished"
        case .supplierRejected:
            return "supplierRejected"
        case .customerCanceled:
            return "customerCanceled"
        case .finishedWithoutAnyBid:
            return "finishedWithoutAnyBid"
        }
    }
}

// MARK: - NotificationType
struct NotificationType:Codable {
    var general, auction, ticket, chat: Int?
    var subscription: Int?
    
    enum CodingKeys: String, CodingKey {
        case chat = "Chat"
        case auction = "Auction"
        case subscription = "Subscription"
        case ticket = "Ticket"
        case general = "General"
    }
}

// MARK: - PaymentMethod
struct PaymentMethod:Codable {
    var bankTransfer, cash: Int?
    
    enum CodingKeys: String, CodingKey {
        case bankTransfer = "BankTransfer"
        case cash = "Cash"
    }
}

// MARK: - SenderType
struct SenderType:Codable {
    var user, admin: Int?
    enum CodingKeys: String, CodingKey {
            case admin = "Admin"
            case user = "User"
        }
}

// MARK: - SubscriptionStatuses
struct SubscriptionStatuses:Codable {
    var pending, approved, rejected, canceled: Int?
    
    enum CodingKeys: String, CodingKey {
            case rejected = "Rejected"
            case pending = "Pending"
            case approved = "Approved"
            case canceled = "Canceled"
        }
}

// MARK: - TicketsStatus
struct TicketsStatus:Codable {
    var ticketsStatusOpen, closed: Int?
    enum CodingKeys: String, CodingKey {
            case ticketsStatusOpen = "Open"
            case closed = "Closed"
        }
}

// MARK: - TransactionStatus
struct TransactionStatus:Codable {
    var pending, paid: Int?
    enum CodingKeys: String, CodingKey {
            case pending = "Pending"
            case paid = "Paid"
        }
}

// MARK: - TransactionTypes
struct TransactionTypes:Codable {
    var deposit, withdraw, holding: Int?
    enum CodingKeys: String, CodingKey {
            case deposit = "Deposit"
            case holding = "Holding"
            case withdraw = "Withdraw"
        }
}

// MARK: - VerificationType
struct VerificationType:Codable {
    var email, mobile: Int?
    enum CodingKeys: String, CodingKey {
            case email = "Email"
            case mobile = "Mobile"
        }
}

// MARK: - Settings
struct Settings:Codable {
    var privacy, about, terms, facebook: String?
    var instagram, email, mobile, extraBiddingTime: String?
    var bidingTime, auctionFinished, waitingSupplierApproval, newBid: String?
    var customerCanceled, auctionFinishedAndReceived, supplierApproved, supplierRejected: String?
    var inAppPurchaseApple: String?
    
    enum CodingKeys: String, CodingKey {
           case supplierApproved = "SupplierApproved"
           case extraBiddingTime = "extra_bidding_time"
           case terms
           case newBid = "NewBid"
           case mobile
           case supplierRejected = "SupplierRejected"
           case about
           case auctionFinished = "AuctionFinished"
           case waitingSupplierApproval = "WaitingSupplierApproval"
           case auctionFinishedAndReceived = "AuctionFinishedAndReceived"
           case inAppPurchaseApple = "in_app_purchase_apple"
           case bidingTime = "BidingTime"
           case privacy, facebook, instagram, email
           case customerCanceled = "CustomerCanceled"
       }
}

