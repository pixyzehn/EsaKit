//
//  Posts.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Posts: Decodable {
    let posts: [Post]
    let prevPage: Int
    let nextPage: Int
    let totalCount: Int

    static func decode(_ e: Extractor) throws -> Posts {
        return try Posts(
            posts: e <|| "posts",
            prevPage: e <| "prev_page",
            nextPage: e <| "next_page",
            totalCount: e <| "total_count"
        )
    }
}
