//
//  Stargazers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Stargazers: AutoEquatable, AutoHashable {
    public let stargazers: [Stargazer]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt
}

extension Stargazers: Decodable {
    public static func decode(_ e: Extractor) throws -> Stargazers {
        return try Stargazers(
            stargazers: e <|| "stargazers",
            page: e <| "page",
            prevPage: e <|? "prev_page",
            nextPage: e <|? "next_page",
            maxPerPage: e <| "max_per_page",
            totalCount: e <| "total_count"
        )
    }
}
