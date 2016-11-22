//
//  Stats.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Stats: Decodable {
    let members: Int
    let posts: Int
    let comments: Int
    let stars: Int
    let dailyActiveUsers: Int
    let weeklyActiveUsers: Int
    let monthlyActiveUsers: Int

    static func decode(_ e: Extractor) throws -> Stats {
        return try Stats(
            members: e <| "members",
            posts: e <| "posts",
            comments: e <| "comments",
            stars: e <| "stars",
            dailyActiveUsers: e <| "daily_active_users",
            weeklyActiveUsers: e <| "weekly_active_users",
            monthlyActiveUsers: e <| "monthly_active_users"
        )
    }
}
