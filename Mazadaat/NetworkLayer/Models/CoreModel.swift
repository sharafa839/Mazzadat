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
}

// MARK: - BankAccount
struct BankAccount:Codable {
    var id: Int?
    var bankName, accountName, accountNumber, accountIban: String?
}

// MARK: - Category
struct Category:Codable {
    var id: Int?
    var name: String?
    var image: String?
    var auctionCount: Int?
}

// MARK: - Country
struct Country:Codable {
    var id: Int?
    var name: String?
    var cities: [City]?
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
}

// MARK: - AuctionStatuses
struct AuctionStatuses :Codable{
    var waitingStart, bidingTime, waitingSupplierApproval, waitingCustomerPayment: Int?
    var finished, supplierRejected, customerCanceled, finishedWithoutAnyBid: Int?
}

// MARK: - NotificationType
struct NotificationType:Codable {
    var general, auction, ticket, chat: Int?
    var subscription: Int?
}

// MARK: - PaymentMethod
struct PaymentMethod:Codable {
    var bankTransfer, cash: Int?
}

// MARK: - SenderType
struct SenderType:Codable {
    var user, admin: Int?
}

// MARK: - SubscriptionStatuses
struct SubscriptionStatuses:Codable {
    var pending, approved, rejected, canceled: Int?
}

// MARK: - TicketsStatus
struct TicketsStatus:Codable {
    var ticketsStatusOpen, closed: Int?
}

// MARK: - TransactionStatus
struct TransactionStatus:Codable {
    var pending, paid: Int?
}

// MARK: - TransactionTypes
struct TransactionTypes:Codable {
    var deposit, withdraw, holding: Int?
}

// MARK: - VerificationType
struct VerificationType:Codable {
    var email, mobile: Int?
}

// MARK: - Settings
struct Settings:Codable {
    var privacy, about, terms, facebook: String?
    var instagram, email, mobile, extraBiddingTime: String?
    var bidingTime, auctionFinished, waitingSupplierApproval, newBid: String?
    var customerCanceled, auctionFinishedAndReceived, supplierApproved, supplierRejected: String?
    var inAppPurchaseApple: String?
}

// MARK: - Subscription
struct Subscription:Codable {
    var id: Int?
    var name, description, price, gainedBalance: String?
}
