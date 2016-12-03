//
//  Members.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Members: Decodable {
    public let members: [MemberUser]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

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

extension Members: Hashable {
    public static func ==(lhs: Members, rhs: Members) -> Bool {
        return lhs.members == rhs.members
            && lhs.page == rhs.page
            && lhs.prevPage == rhs.prevPage
            && lhs.nextPage == rhs.nextPage
            && lhs.maxPerPage == rhs.maxPerPage
            && lhs.totalCount == rhs.totalCount
    }

    public var hashValue: Int {
        return page.hashValue
    }
}