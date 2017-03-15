//
//  Watchers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Watchers: AutoEquatable, AutoHashable {
    public let watchers: [Watcher]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt
}

extension Watchers: Decodable {
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
