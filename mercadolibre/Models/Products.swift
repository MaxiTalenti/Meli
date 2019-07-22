//
//  Product.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 19/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let products = try? newJSONDecoder().decode(Products.self, from: jsonData)

import Foundation

// MARK: - Products
struct Products: Codable {
    let siteID, query: String?
    let paging: Paging
    let results: [Result]
    let secondaryResults, relatedResults: [JSONAny]?
    let sort: Sort
    let availableSorts: [Sort]?
    let filters: [JSONAny]?
    let availableFilters: [AvailableFilter]?
    
    enum CodingKeys: String, CodingKey {
        case siteID
        case query, paging, results
        case secondaryResults
        case relatedResults
        case sort
        case availableSorts
        case filters
        case availableFilters
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id, name, type: String
    let values: [Value]
}

// MARK: - Value
struct Value: Codable {
    let id, name: String
    let results: Int
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String
}

// MARK: - Paging
struct Paging: Codable {
    let total, offset, limit, primaryResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults
    }
}

// MARK: - Result
struct Result: Codable {
    let id, siteID, title: String?
    let seller: Seller?
    let price: Double
    let currencyID: String?
    let availableQuantity, soldQuantity: Int?
    let buyingMode, listingTypeID, stopTime, condition: String?
    let permalink: String
    let thumbnail: String
    let acceptsMercadopago: Bool?
    let installments: Installments?
    let address: Address?
    let shipping: Shipping?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]
    let originalPrice: Int?
    let categoryID: String?
    let officialStoreID: Int?
    let catalogProductID: String?
    let tags: [String]
    let differentialPricing: DifferentialPricing?
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID
        case title, seller, price
        case currencyID
        case availableQuantity
        case soldQuantity
        case buyingMode
        case listingTypeID
        case stopTime
        case condition, permalink, thumbnail
        case acceptsMercadopago
        case installments, address, shipping
        case sellerAddress
        case attributes
        case originalPrice
        case categoryID
        case officialStoreID
        case catalogProductID
        case tags
        case differentialPricing
    }
}

// MARK: - Address
struct Address: Codable {
    let stateID, stateName: String?
    let cityID: String?
    let cityName: String?
    
    enum CodingKeys: String, CodingKey {
        case stateID
        case stateName
        case cityID
        case cityName
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let valueName: String?
    let valueStruct: JSONNull?
    let attributeGroupID, attributeGroupName: String?
    let source: Int?
    let id, name: String?
    let valueID: String?
    
    enum CodingKeys: String, CodingKey {
        case valueName
        case valueStruct
        case attributeGroupID
        case attributeGroupName
        case source, id, name
        case valueID
    }
}

// MARK: - DifferentialPricing
struct DifferentialPricing: Codable {
    let id: Int
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int
    let amount, rate: Double
    let currencyID: String?
    
    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID
    }
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int
    let powerSellerStatus: String?
    let carDealer, realEstateAgency: Bool?
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case powerSellerStatus
        case carDealer
        case realEstateAgency
        case tags
    }
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let id, comment, addressLine, zipCode: String?
    let country, state: Sort
    let city: City
    let latitude, longitude: String
    
    enum CodingKeys: String, CodingKey {
        case id, comment
        case addressLine
        case zipCode
        case country, state, city, latitude, longitude
    }
}

// MARK: - City
struct City: Codable {
    let id: String?
    let name: String?
}

// MARK: - Shipping
struct Shipping: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping
        case mode, tags
        case logisticType
        case storePickUp
    }
}










// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

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
