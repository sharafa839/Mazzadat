//
//  WishListMode.swift
//  Dana
//
//  Created by Sharaf on 21/05/2022.
//

import Foundation

// MARK: - Payload
struct WishListPayload: Codable {
    var id:Int?
    var productID: String?
    var cartID: String?
    var userID: String?
    var price: String?
    var quantity:String?
    var amount: String?
    var createdAt, updatedAt: String?
    var product: WishListProduct?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case cartID = "cart_id"
        case userID = "user_id"
        case price, quantity, amount
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case product
    }
}

// MARK: - Product
struct WishListProduct: Codable {
    var id:Int?
var client: String?
    var enTitle, arTitle, sku, slug: String?
    var enDescription: String?
    var arDescription: String?
    var enDetails, arDetails: String?
    var stock, acive: String?
    var price: String?
    var new, isUsed, sale: String?
    var discount: String?
    var outstock, isDigital: String?
    var productLink, license: String?
    var delete: String?
    var createdAt, updatedAt: String?
    var categoryID: String?
    var photo: Photo?
    var gallery, media: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case id, client
        case enTitle = "en_title"
        case arTitle = "ar_title"
        case sku, slug
        case enDescription = "en_description"
        case arDescription = "ar_description"
        case enDetails = "en_details"
        case arDetails = "ar_details"
        case stock, acive, price, new
        case isUsed = "is_used"
        case sale, discount, outstock
        case isDigital = "is_digital"
        case productLink = "product_link"
        case license, delete
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
        case photo, gallery, media
    }
}

// MARK: - Photo
struct Photo: Codable {
    var id: Int?
    var modelType: String?
    var modelID: String?
    var uuid, collectionName, name, fileName: String?
    var mimeType, disk, conversionsDisk: String?
    var size: String?
    var manipulations: [JSONAny]?
    var customProperties: CustomProperties?
    var responsiveImages: [JSONAny]?
    var orderColumn: String?
    var createdAt, updatedAt: String?
    var url: String?
    var thumbnail, preview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case modelType = "model_type"
        case modelID = "model_id"
        case uuid
        case collectionName = "collection_name"
        case name
        case fileName = "file_name"
        case mimeType = "mime_type"
        case disk
        case conversionsDisk = "conversions_disk"
        case size, manipulations
        case customProperties = "custom_properties"
        case responsiveImages = "responsive_images"
        case orderColumn = "order_column"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url, thumbnail, preview
    }
}

// MARK: - CustomProperties
struct CustomProperties: Codable {
    var generatedConversions: GeneratedConversions?
    
    enum CodingKeys: String, CodingKey {
        case generatedConversions = "generated_conversions"
    }
}

// MARK: - GeneratedConversions
struct GeneratedConversions: Codable {
    var thumb, preview: Bool?
}

// MARK: - Encode/decode helpers



class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
