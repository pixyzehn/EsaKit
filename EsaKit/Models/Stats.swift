//
//  Stats.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Stats: Decodable {
    public let members: Int
    public let posts: Int
    public let comments: Int
    public let stars: Int
    public let dailyActiveUsers: Int
    public let weeklyActiveUsers: Int
    public let monthlyActiveUsers: Int

    public static func decode(_ e: Extractor) throws -> Stats {
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
