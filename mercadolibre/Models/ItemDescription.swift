//
//  ItemDescription.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 22/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import Foundation

// MARK: - ItemDescription
struct ItemDescription: Codable {
    let text, plainText, lastUpdated, dateCreated: String?
    let snapshot: Snapshot
    
    enum CodingKeys: String, CodingKey {
        case text
        case plainText
        case lastUpdated
        case dateCreated
        case snapshot
    }
}

// MARK: ItemDescription convenience initializers and mutators

extension ItemDescription {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ItemDescription.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        text: String? = nil,
        plainText: String? = nil,
        lastUpdated: String? = nil,
        dateCreated: String? = nil,
        snapshot: Snapshot? = nil
        ) -> ItemDescription {
        return ItemDescription(
            text: text ?? self.text,
            plainText: plainText ?? self.plainText,
            lastUpdated: lastUpdated ?? self.lastUpdated,
            dateCreated: dateCreated ?? self.dateCreated,
            snapshot: snapshot ?? self.snapshot
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
    let url: String
    let width, height: Int
    let status: String
}

// MARK: Snapshot convenience initializers and mutators

extension Snapshot {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Snapshot.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        url: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        status: String? = nil
        ) -> Snapshot {
        return Snapshot(
            url: url ?? self.url,
            width: width ?? self.width,
            height: height ?? self.height,
            status: status ?? self.status
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
