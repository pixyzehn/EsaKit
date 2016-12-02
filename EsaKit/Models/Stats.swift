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
    public let members: UInt
    public let posts: UInt
    public let postsWip: UInt
    public let postsShipped: UInt
    public let comments: UInt
    public let stars: UInt
    public let dailyActiveUsers: UInt
    public let weeklyActiveUsers: UInt
    public let monthlyActiveUsers: UInt

    public static func decode(_ e: Extractor) throws -> Stats {
        return try Stats(
            members: e <| "members",
            posts: e <| "posts",
            postsWip: e <| "posts_wip",
            postsShipped: e <| "posts_shipped",
            comments: e <| "comments",
            stars: e <| "stars",
            dailyActiveUsers: e <| "daily_active_users",
            weeklyActiveUsers: e <| "weekly_active_users",
            monthlyActiveUsers: e <| "monthly_active_users"
        )
    }
}

extension Stats: Hashable {
    public static func ==(lhs: Stats, rhs: Stats) -> Bool {
        return lhs.members == rhs.members
            && lhs.posts == rhs.posts
            && lhs.postsWip == rhs.postsWip
            && lhs.postsShipped == rhs.postsShipped
            && lhs.comments == rhs.comments
            && lhs.stars == rhs.stars
            && lhs.dailyActiveUsers == rhs.dailyActiveUsers
            && lhs.weeklyActiveUsers == rhs.weeklyActiveUsers
            && lhs.monthlyActiveUsers == rhs.monthlyActiveUsers
    }

    public var hashValue: Int {
        return members.hashValue
    }
}
