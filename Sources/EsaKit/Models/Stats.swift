//
//  Stats.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Stats: AutoEquatable, AutoHashable {
    public let members: UInt
    public let posts: UInt
    public let postsWip: UInt
    public let postsShipped: UInt
    public let comments: UInt
    public let stars: UInt
    public let dailyActiveUsers: UInt
    public let weeklyActiveUsers: UInt
    public let monthlyActiveUsers: UInt

    enum Key: String {
        case members
        case posts
        case postsWip = "posts_wip"
        case postsShipped = "posts_shipped"
        case comments
        case stars
        case dailyActiveUsers = "daily_active_users"
        case weeklyActiveUsers = "weekly_active_users"
        case monthlyActiveUsers = "monthly_active_users"
    }
}

extension Stats: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Stats {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let members = dictionary[Key.members.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.members.rawValue, actualValue: dictionary[Key.members.rawValue])
        }

        guard let posts = dictionary[Key.posts.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.posts.rawValue, actualValue: dictionary[Key.posts.rawValue])
        }

        guard let postsWip = dictionary[Key.postsWip.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.postsWip.rawValue, actualValue: dictionary[Key.postsWip.rawValue])
        }

        guard let postsShipped = dictionary[Key.postsShipped.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.postsShipped.rawValue, actualValue: dictionary[Key.postsShipped.rawValue])
        }

        guard let comments = dictionary[Key.comments.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.comments.rawValue, actualValue: dictionary[Key.comments.rawValue])
        }

        guard let stars = dictionary[Key.stars.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.stars.rawValue, actualValue: dictionary[Key.stars.rawValue])
        }

        guard let dailyActiveUsers = dictionary[Key.dailyActiveUsers.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.dailyActiveUsers.rawValue, actualValue: dictionary[Key.dailyActiveUsers.rawValue])
        }

        guard let weeklyActiveUsers = dictionary[Key.weeklyActiveUsers.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.weeklyActiveUsers.rawValue, actualValue: dictionary[Key.weeklyActiveUsers.rawValue])
        }

        guard let monthlyActiveUsers = dictionary[Key.monthlyActiveUsers.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.monthlyActiveUsers.rawValue, actualValue: dictionary[Key.monthlyActiveUsers.rawValue])
        }

        return Stats(
            members: members,
            posts: posts,
            postsWip: postsWip,
            postsShipped: postsShipped,
            comments: comments,
            stars: stars,
            dailyActiveUsers: dailyActiveUsers,
            weeklyActiveUsers: weeklyActiveUsers,
            monthlyActiveUsers: monthlyActiveUsers
        )
    }
}
