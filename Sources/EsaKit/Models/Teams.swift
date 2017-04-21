//
//  Teams.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Teams: AutoEquatable, AutoHashable {
    public let teams: [Team]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    enum Key: String {
        case teams
        case page
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case maxPerPage = "max_per_page"
        case totalCount = "total_count"
    }
}

extension Teams: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Teams {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let teamsJSON = dictionary[Key.teams.rawValue] as? [Any] else {
            throw DecodeError.missingValue(key: Key.teams.rawValue, actualValue: dictionary[Key.teams.rawValue])
        }

        var teams: [Team] = []
        for teamJSON in teamsJSON {
            guard let team = try? Team.decode(json: teamJSON) else {
                throw DecodeError.invalidFormat(json: teamJSON)
            }
            teams.append(team)
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

        return Teams(
            teams: teams,
            page: page,
            prevPage: dictionary[Key.prevPage.rawValue] as? UInt,
            nextPage: dictionary[Key.nextPage.rawValue] as? UInt,
            maxPerPage: maxPerPage,
            totalCount: totalCount
        )
    }
}
