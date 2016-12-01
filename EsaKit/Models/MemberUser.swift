//
//  MemberUser.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/29.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct MemberUser: Decodable {
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

extension MemberUser: Hashable {
    public static func ==(lhs: MemberUser, rhs: MemberUser) -> Bool {
        return lhs.name == rhs.name
            && lhs.screenName == rhs.screenName
            && lhs.icon == rhs.icon
            && lhs.email == rhs.email
            && lhs.postsCount == rhs.postsCount
    }

    public var hashValue: Int {
        return name.hashValue
    }
}
