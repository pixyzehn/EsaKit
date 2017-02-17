//
//  User.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct User: Decodable {
    public let id: Int
    public let name: String
    public let screenName: String
    public let createdAt: Date
    public let updatedAt: Date
    public let icon: URL
    public let email: String

    public static func decode(_ e: Extractor) throws -> User {
        return try User(
            id: e <| "id",
            name: e <| "name",
            screenName: e <| "screen_name",
            createdAt: try Transformer { try toDate($0) }.apply(e <| "created_at"),
            updatedAt: try Transformer { try toDate($0) }.apply(e <| "updated_at"),
            icon: Transformer { try toURL($0) }.apply(e <| "icon"),
            email: e <| "email"
        )
    }
}

extension User: Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.screenName == rhs.screenName
            && lhs.createdAt == rhs.createdAt
            && lhs.updatedAt == rhs.updatedAt
            && lhs.icon == rhs.icon
            && lhs.email == rhs.email
    }

    public var hashValue: Int {
        return id.hashValue
    }
}
