//
//  Stargazer.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Stargazer: Decodable {
    public let user: MinimumUser
    public let createdAt: Date
    public let body: String?

    public static func decode(_ e: Extractor) throws -> Stargazer {
        return try Stargazer(
            user: e <| "user",
            createdAt: try Transformer { try toDate($0) }.apply(e <| "created_at"),
            body: e <|? "body"
        )
    }
}

extension Stargazer: Hashable {
    public static func ==(lhs: Stargazer, rhs: Stargazer) -> Bool {
        return lhs.user == rhs.user
            && lhs.createdAt == rhs.createdAt
            && lhs.body == rhs.body
    }

    public var hashValue: Int {
        return user.name.hashValue
    }
}
