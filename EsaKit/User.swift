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
    public var id: Int
    public var name: String
    public var screenName: String
    public var createdAt: String
    public var updatedAt: String
    public var icon: String
    public var email: String

    public static func decode(_ e: Extractor) throws -> User {
        return try User(
            id: e <| "id",
            name: e <| "name",
            screenName: e <| "screen_name",
            createdAt: e <| "created_at",
            updatedAt: e <| "updated_at",
            icon: e <| "icon",
            email: e <| "email"
        )
    }
}
