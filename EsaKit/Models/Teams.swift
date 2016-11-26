//
//  Teams.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Teams: Decodable {
    public let teams: [Team]
    public let page: Int
    public let prevPage: Int?
    public let nextPage: Int?
    public let maxPerPage: Int
    public let totalCount: Int

    public static func decode(_ e: Extractor) throws -> Teams {
        return try Teams(
            teams: e <|| "teams",
            page: e <| "page",
            prevPage: e <|? "prev_page",
            nextPage: e <|? "next_page",
            maxPerPage: e <| "max_per_page",
            totalCount: e <| "total_count"
        )
    }
}
