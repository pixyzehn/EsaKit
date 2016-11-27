//
//  Members.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct MemberUser: Decodable {
    public let name: String
    public let screenName: String
    public let icon: URL
    public let email: String
    public let postsCount: Int

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

public struct Members: Decodable {
    public let members: [MemberUser]
    public let page: Int
    public let prevPage: Int?
    public let nextPage: Int?
    public let maxPerPage: Int
    public let totalCount: Int

    public static func decode(_ e: Extractor) throws -> Members {
        return try Members(
            members: e <|| "members",
            page: e <| "page",
            prevPage: e <|? "prev_page",
            nextPage: e <|? "next_page",
            maxPerPage: e <| "max_per_page",
            totalCount: e <| "total_count"
        )
    }
}
