//
//  User.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct User: Decodable {
    var id: Int
    var name: String
    var screenName: String
    var createdAt: String
    var updatedAt: String
    var icon: String
    var email: String

    static func decode(_ e: Extractor) throws -> User {
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
