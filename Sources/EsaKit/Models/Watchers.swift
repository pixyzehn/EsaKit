//
//  Watchers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Watchers: AutoEquatable, AutoHashable {
    public let watchers: [Watcher]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    enum Key: String {
        case watchers
        case page
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case maxPerPage = "max_per_page"
        case totalCount = "total_count"
    }
}

extension Watchers: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Watchers {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let watchersJSON = dictionary[Key.watchers.rawValue] as? [Any] else {
            throw DecodeError.missingValue(key: Key.watchers.rawValue, actualValue: dictionary[Key.watchers.rawValue])
        }

        var watchers: [Watcher] = []
        for watcherJSON in watchersJSON {
            guard let watcher = try? Watcher.decode(json: watcherJSON) else {
                throw DecodeError.invalidFormat(json: watcherJSON)
            }
            watchers.append(watcher)
        }

        guard let page = dictionary[Key.page.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.page.rawValue, actualValue: dictionary[Key.page.rawValue])
        }

        guard let maxPerPage = dictionary[Key.maxPerPage.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.maxPerPage.rawValue, actualValue: dictionary[Key.maxPerPage.rawValue])
        }

        guard let totalCount = dictionary[Key.totalCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.totalCount.rawValue, actualValue: dictionary[Key.totalCount.rawValue])
        }

        return Watchers(
            watchers: watchers,
            page: page,
            prevPage: dictionary[Key.prevPage.rawValue] as? UInt,
            nextPage: dictionary[Key.nextPage.rawValue] as? UInt,
            maxPerPage: maxPerPage,
            totalCount: totalCount
        )
    }
}
