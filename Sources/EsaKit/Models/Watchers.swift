//
//  Watchers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Watchers: Decodable {
    public let watchers: [Watcher]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    public static func decode(_ e: Extractor) throws -> Watchers {
        return try Watchers(
            watchers: e <|| "watchers",
            page: e <| "page",
            prevPage: e <|? "prev_page",
            nextPage: e <|? "next_page",
            maxPerPage: e <| "max_per_page",
            totalCount: e <| "total_count"
        )
    }
}

extension Watchers: Hashable {
    public static func == (lhs: Watchers, rhs: Watchers) -> Bool {
        return lhs.watchers == rhs.watchers
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
