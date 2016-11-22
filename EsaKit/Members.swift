//
//  Members.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Members: Decodable {
    let members: [Member]
    let prevPage: Int
    let nextPage: Int
    let totalCount: Int

    static func decode(_ e: Extractor) throws -> Members {
        return try Members(
            members: e <|| "members",
            prevPage: e <| "prev_page",
            nextPage: e <| "next_page",
            totalCount: e <| "total_count"
        )
    }
}
