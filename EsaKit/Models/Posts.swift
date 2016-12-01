//
//  Posts.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Posts: Decodable {
    public let posts: [Post]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let perPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    public static func decode(_ e: Extractor) throws -> Posts {
        return try Posts(
            posts: e <|| "posts",
            page: e <| "page",
            prevPage: e <|? "prev_page",
            nextPage: e <|? "next_page",
            perPage: e <|? "per_page",
            maxPerPage: e <| "max_per_page",
            totalCount: e <| "total_count"
        )
    }
}

extension Posts: Hashable {
    public static func == (lhs: Posts, rhs: Posts) -> Bool {
        return lhs.posts == rhs.posts
            && lhs.page == rhs.page
            && lhs.prevPage == rhs.prevPage
            && lhs.nextPage == rhs.nextPage
            && lhs.perPage == rhs.perPage
            && lhs.maxPerPage == rhs.maxPerPage
            && lhs.totalCount == rhs.totalCount
    }

    public var hashValue: Int {
        return page.hashValue
    }
}
