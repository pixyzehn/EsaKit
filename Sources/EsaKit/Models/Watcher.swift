//
//  Watcher.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Watcher: AutoEquatable, AutoHashable {
    public let user: MinimumUser
    public let createdAt: Date

    enum Key: String {
        case user
        case createdAt = "created_at"
    }
}

extension Watcher: Decodable {
    public static func decode(json: Any) throws -> Watcher {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let userJSON = dictionary[Key.user.rawValue] else {
            throw DecodeError.missingValue(key: Key.user.rawValue, actualValue: dictionary[Key.user.rawValue])
        }
        let user: MinimumUser
        do {
            user = try MinimumUser.decode(json: userJSON)
        } catch {
            throw DecodeError.custom(error.localizedDescription)
        }

        guard let createdAtString = dictionary[Key.createdAt.rawValue] as? String,
              let createdAt = DateFormatter.iso8601.date(from: createdAtString) else {
            throw DecodeError.missingValue(key: Key.createdAt.rawValue, actualValue: dictionary[Key.createdAt.rawValue])
        }

        return Watcher(
            user: user,
            createdAt: createdAt
        )
    }
}
