//
//  Teams.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Teams: Decodable {
    let teams: [Team]
    let prevPage: Int
    let nextPage: Int
    let totalCount: Int

    static func decode(_ e: Extractor) throws -> Teams {
        return try Teams(
            teams: e <|| "teams",
            prevPage: e <| "prev_page",
            nextPage: e <| "next_page",
            totalCount: e <| "total_count"
        )
    }
}
