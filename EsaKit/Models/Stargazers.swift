//
//  Stargazers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Stargazers: Decodable {
    public let stargazers: [Stargazer]
    public let page: Int
    public let prevPage: Int?
    public let nextPage: Int?
    public let maxPerPage: Int
    public let totalCount: Int

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
