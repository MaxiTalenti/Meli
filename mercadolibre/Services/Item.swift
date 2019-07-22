//
//  Item.swift
//  mercadolibre
//
//  Created by Maximiliano Talention 21/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    let id, siteID, title: String?
    let sellerID: Int?
    let categoryID: String?
    let price, basePrice: Double?
    let currencyID: String?
    let initialQuantity, availableQuantity, soldQuantity: Int?
    let buyingMode, listingTypeID, startTime, stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Picture]
    let acceptsMercadopago: Bool?
    let shipping: Shipping?
    let internationalDeliveryMode: String?
    let sellerAddress: SellerAddress?
    let geolocation: Geolocation?
    let status, warranty, catalogProductID, domainID: String?
    let automaticRelist: Bool?
    let dateCreated, lastUpdated: String?
    let health: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID
        case title
        case sellerID
        case categoryID
        case price
        case basePrice
        case currencyID
        case initialQuantity
        case availableQuantity
        case soldQuantity
        case buyingMode
        case listingTypeID
        case startTime
        case stopTime
        case condition, permalink, thumbnail
        case secureThumbnail
        case pictures
        case acceptsMercadopago
        case shipping
        case internationalDeliveryMode
        case sellerAddress
        case geolocation, status, warranty
        case catalogProductID
        case domainID
        case automaticRelist
        case dateCreated
        case lastUpdated
        case health
    }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let latitude, longitude: Double
}

// MARK: - Picture
struct Picture: Codable {
    let id: String?
    let url: String
    let secureURL: String?
    let size, maxSize, quality: String?
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL
        case size
        case maxSize
        case quality
    }
}

// MARK: - Rule
struct Rule: Codable {
    let ruleDefault: Bool
    let freeMode: String
    let freeShippingFlag: Bool
    
    enum CodingKeys: String, CodingKey {
        case ruleDefault
        case freeMode
        case freeShippingFlag
    }
}
