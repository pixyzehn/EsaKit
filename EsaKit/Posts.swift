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
    public let prevPage: Int
    public let nextPage: Int
    public let totalCount: Int

    public static func decode(_ e: Extractor) throws -> Posts {
        return try Posts(
            posts: e <|| "posts",
            prevPage: e <| "prev_page",
            nextPage: e <| "next_page",
            totalCount: e <| "total_count"
        )
    }
}
