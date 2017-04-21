//
//  MemberUser.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/29.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct MemberUser: AutoEquatable, AutoHashable {
    public let name: String
    public let screenName: String
    public let icon: URL
    public let email: String
    public let postsCount: UInt

    enum Key: String {
        case name
        case screenName = "screen_name"
        case icon
        case email
        case postsCount = "posts_count"
    }
}

extension MemberUser: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> MemberUser {
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

        guard let email = dictionary[Key.email.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.email.rawValue, actualValue: dictionary[Key.email.rawValue])
        }

        guard let postsCount = dictionary[Key.postsCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.postsCount.rawValue, actualValue: dictionary[Key.postsCount.rawValue])
        }

        return MemberUser(
            name: name,
            screenName: screenName,
            icon: icon,
            email: email,
            postsCount: postsCount
        )
    }
}
