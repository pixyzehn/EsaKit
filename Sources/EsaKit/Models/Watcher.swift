//
//  Watcher.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Watcher: Decodable {
    public let user: MinimumUser
    public let createdAt: Date

    public static func decode(_ e: Extractor) throws -> Watcher {
        return try Watcher(
            user: e <| "user",
            createdAt: try Transformer { try toDate($0) }.apply(e <| "created_at")
        )
    }
}

extension Watcher: Hashable {
    public static func == (lhs: Watcher, rhs: Watcher) -> Bool {
        return lhs.user == rhs.user
            && lhs.createdAt == rhs.createdAt
    }

    public var hashValue: Int {
        return user.name.hashValue
    }
}
