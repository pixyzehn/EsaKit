//
//  Stargazer.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Stargazer: AutoEquatable, AutoHashable {
    public let user: MinimumUser
    public let createdAt: Date
    public let body: String?

    enum Key: String {
        case user
        case createdAt = "created_at"
        case body
    }
}

extension Stargazer: Decodable {
    public static func decode(json: Any) throws -> Stargazer {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let userJSON = dictionary[Key.user.rawValue],
              let user = try? MinimumUser.decode(json: userJSON) else {
            throw DecodeError.missingValue(key: Key.user.rawValue, actualValue: dictionary[Key.user.rawValue])
        }

        guard let createdAtString = dictionary[Key.createdAt.rawValue] as? String,
              let createdAt = DateFormatter.iso8601.date(from: createdAtString) else {
            throw DecodeError.missingValue(key: Key.createdAt.rawValue, actualValue: dictionary[Key.createdAt.rawValue])
        }

        return Stargazer(
            user: user,
            createdAt: createdAt,
            body: dictionary[Key.body.rawValue] as? String
        )
    }
}
