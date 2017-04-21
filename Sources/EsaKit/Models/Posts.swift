//
//  Posts.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Posts: AutoEquatable, AutoHashable {
    public let posts: [Post]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let perPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    enum Key: String {
        case posts
        case page
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case perPage = "per_page"
        case maxPerPage = "max_per_page"
        case totalCount = "total_count"
    }
}

extension Posts: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Posts {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let postsJSON = dictionary[Key.posts.rawValue] as? [Any] else {
            throw DecodeError.missingValue(key: Key.posts.rawValue, actualValue: dictionary[Key.posts.rawValue])
        }

        var posts: [Post] = []
        for postJSON in postsJSON {
            guard let post = try? Post.decode(json: postJSON) else {
                throw DecodeError.invalidFormat(json: postJSON)
            }
            posts.append(post)
        }

        guard let page = dictionary[Key.page.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.page.rawValue, actualValue: dictionary[Key.page.rawValue])
        }

        guard let perPage = dictionary[Key.perPage.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.perPage.rawValue, actualValue: dictionary[Key.perPage.rawValue])
        }

        guard let maxPerPage = dictionary[Key.maxPerPage.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.maxPerPage.rawValue, actualValue: dictionary[Key.maxPerPage.rawValue])
        }

        guard let totalCount = dictionary[Key.totalCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.totalCount.rawValue, actualValue: dictionary[Key.totalCount.rawValue])
        }

        return Posts(
            posts: posts,
            page: page,
            prevPage: dictionary[Key.prevPage.rawValue] as? UInt,
            nextPage: dictionary[Key.nextPage.rawValue] as? UInt,
            perPage: perPage,
            maxPerPage: maxPerPage,
            totalCount: totalCount
        )
    }
}
