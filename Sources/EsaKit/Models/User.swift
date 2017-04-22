//
//  User.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct User: AutoEquatable, AutoHashable {
    public let id: Int
    public let name: String
    public let screenName: String
    public let createdAt: Date
    public let updatedAt: Date
    public let icon: URL
    public let email: String

    enum Key: String {
        case id
        case name
        case screenName = "screen_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case icon
        case email
    }
}

extension User: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> User {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let id = dictionary[Key.id.rawValue] as? Int else {
            throw DecodeError.missingValue(key: Key.id.rawValue, actualValue: dictionary[Key.id.rawValue])
        }

        guard let name = dictionary[Key.name.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.name.rawValue, actualValue: dictionary[Key.name.rawValue])
        }

        guard let screenName = dictionary[Key.screenName.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.screenName.rawValue, actualValue: dictionary[Key.screenName.rawValue])
        }

        guard let createdAtString = dictionary[Key.createdAt.rawValue] as? String,
              let createdAt = DateFormatter.iso8601.date(from: createdAtString) else {
            throw DecodeError.missingValue(key: Key.createdAt.rawValue, actualValue: dictionary[Key.createdAt.rawValue])
        }

        guard let updatedAtString = dictionary[Key.updatedAt.rawValue] as? String,
              let updatedAt = DateFormatter.iso8601.date(from: updatedAtString) else {
            throw DecodeError.missingValue(key: Key.updatedAt.rawValue, actualValue: dictionary[Key.updatedAt.rawValue])
        }

        guard let iconString = dictionary[Key.icon.rawValue] as? String,
              let icon = URL(string: iconString) else {
            throw DecodeError.missingValue(key: Key.icon.rawValue, actualValue: dictionary[Key.icon.rawValue])
        }

        guard let email = dictionary[Key.email.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.email.rawValue, actualValue: dictionary[Key.email.rawValue])
        }

        return User(
            id: id,
            name: name,
            screenName: screenName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            icon: icon,
            email: email
        )
    }
}
