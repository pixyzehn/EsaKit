//
//  Stargazers.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Stargazers: AutoEquatable, AutoHashable {
    public let stargazers: [Stargazer]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    enum Key: String {
        case stargazers
        case page
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case maxPerPage = "max_per_page"
        case totalCount = "total_count"
    }
}

extension Stargazers: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Stargazers {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let stargazersJSON = dictionary[Key.stargazers.rawValue] as? [Any] else {
            throw DecodeError.missingValue(key: Key.stargazers.rawValue, actualValue: dictionary[Key.stargazers.rawValue])
        }
        var stargazers: [Stargazer] = []
        for stargazerJSON in stargazersJSON {
            let stargazer: Stargazer
            do {
                stargazer = try Stargazer.decode(json: stargazerJSON)
            } catch {
                throw DecodeError.custom(error.localizedDescription)
            }
            stargazers.append(stargazer)
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

        return Stargazers(
            stargazers: stargazers,
            page: page,
            prevPage: dictionary[Key.prevPage.rawValue] as? UInt,
            nextPage: dictionary[Key.nextPage.rawValue] as? UInt,
            maxPerPage: maxPerPage,
            totalCount: totalCount
        )
    }
}
