//
//  User.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct User: Decodable, AutoEquatable, AutoHashable {
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
