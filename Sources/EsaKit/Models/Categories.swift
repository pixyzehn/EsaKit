//
//  Categories.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/03/02.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Foundation

public struct Categories: AutoEquatable, AutoHashable {
    public let count: Int
    public let from: String
    public let to: String

    enum Key: String {
        case count
        case from
        case to
    }
}

extension Categories: Decodable {
    public static func decode(json: Any) throws -> Categories {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let count = dictionary[Key.count.rawValue] as? Int else {
            throw DecodeError.missingValue(key: Key.count.rawValue, actualValue: dictionary[Key.count.rawValue])
        }

        guard let from = dictionary[Key.from.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.from.rawValue, actualValue: dictionary[Key.from.rawValue])
        }

        guard let to = dictionary[Key.to.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.to.rawValue, actualValue: dictionary[Key.to.rawValue])
        }

        return Categories(
            count: count,
            from: from,
            to: to
        )
    }
}
