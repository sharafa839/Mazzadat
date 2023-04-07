
import Foundation


// MARK: - Payload
struct MyOrderersPayload: Codable {
    var id, customerID: String?
    var paymentStatus: String?
    var status: String?
    var currency: String?
    var totalCost: String?
    var shipping: Shipping?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customerId"
        case paymentStatus, status, currency, totalCost, shipping
    }
}

enum Currency: String, Codable {
    case omr = "OMR"
}

enum PaymentStatus: String, Codable {
    case paid = "paid"
    case unpaid = "unpaid"
}

// MARK: - Shipping
struct Shipping: Codable {
    var address: Address?
    var phone: String?
}

// MARK: - Address
struct Address: Codable {
    var address1, postCode: String?
    var city: String?
    var country: String?

    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case postCode = "post_code"
        case city, country
    }
}



// MARK: - Payload
struct DownloadDigitalPayload: Codable {
    var titleEn, titleAr: String?
    var serials: [Serial]?
    var productLink: String?

    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case serials
        case productLink = "product_link"
    }
}

// MARK: - Serial
struct Serial: Codable {
    var id: Int?
    var serial, used, createdAt, updatedAt: String?
    var productID, userID: String?

    enum CodingKeys: String, CodingKey {
        case id, serial, used
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case productID = "product_id"
        case userID = "user_id"
    }
}

