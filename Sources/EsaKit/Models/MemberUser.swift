//
//  MemberUser.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/29.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct MemberUser: Decodable, AutoEquatable, AutoHashable {
    public let name: String
    public let screenName: String
    public let icon: URL
    public let email: String
    public let postsCount: UInt

    public static func decode(_ e: Extractor) throws -> MemberUser {
        return try MemberUser(
            name: e <| "name",
            screenName: e <| "screen_name",
            icon: Transformer { try toURL($0) }.apply(e <| "icon"),
            email: e <| "email",
            postsCount: e <| "posts_count"
        )
    }
}
