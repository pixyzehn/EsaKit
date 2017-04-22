//
//  Team.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Team: AutoEquatable, AutoHashable {
    public var name: String
    public var privacy: String
    public var description: String
    public var icon: URL
    public var url: URL

    enum Key: String {
        case name
        case privacy
        case description
        case icon
        case url
    }
}

extension Team: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Team {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let name = dictionary[Key.name.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.name.rawValue, actualValue: dictionary[Key.name.rawValue])
        }

        guard let privacy = dictionary[Key.privacy.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.privacy.rawValue, actualValue: dictionary[Key.privacy.rawValue])
        }

        guard let description = dictionary[Key.description.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.description.rawValue, actualValue: dictionary[Key.description.rawValue])
        }

        guard let iconString = dictionary[Key.icon.rawValue] as? String,
              let icon = URL(string: iconString) else {
            throw DecodeError.missingValue(key: Key.icon.rawValue, actualValue: dictionary[Key.icon.rawValue])
        }

        guard let urlString = dictionary[Key.url.rawValue] as? String,
              let url = URL(string: urlString) else {
            throw DecodeError.missingValue(key: Key.url.rawValue, actualValue: dictionary[Key.url.rawValue])
        }

        return Team(
            name: name,
            privacy: privacy,
            description: description,
            icon: icon,
            url: url
        )
    }
}
