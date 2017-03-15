//
//  Posts.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Posts: AutoEquatable, AutoHashable {
    public let posts: [Post]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let perPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt
}

extension Posts: Decodable {
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
