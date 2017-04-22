//
//  MinimumUser.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct MinimumUser: AutoEquatable, AutoHashable {
    public let name: String
    public let screenName: String
    public let icon: URL

    enum Key: String {
        case name
        case screenName = "screen_name"
        case icon
    }
}

extension MinimumUser: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> MinimumUser {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let name = dictionary[Key.name.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.name.rawValue, actualValue: dictionary[Key.name.rawValue])
        }

        guard let screenName = dictionary[Key.screenName.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.screenName.rawValue, actualValue: dictionary[Key.screenName.rawValue])
        }

        guard let iconString = dictionary[Key.icon.rawValue] as? String,
              let icon = URL(string: iconString) else {
            throw DecodeError.missingValue(key: Key.icon.rawValue, actualValue: dictionary[Key.icon.rawValue])
        }

        return MinimumUser(
            name: name,
            screenName: screenName,
            icon: icon
        )
    }
}
