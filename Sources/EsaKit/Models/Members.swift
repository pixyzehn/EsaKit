//
//  Members.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Members: AutoEquatable, AutoHashable {
    public let members: [MemberUser]
    public let page: UInt
    public let prevPage: UInt?
    public let nextPage: UInt?
    public let maxPerPage: UInt
    public let totalCount: UInt

    enum Key: String {
        case members
        case page
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case maxPerPage = "max_per_page"
        case totalCount = "total_count"
    }
}

extension Members: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Members {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let membersJSON = dictionary[Key.members.rawValue] as? [Any] else {
            throw DecodeError.missingValue(key: Key.members.rawValue, actualValue: dictionary[Key.members.rawValue])
        }
        var members: [MemberUser] = []
        for memberJSON in membersJSON {
            let member: MemberUser
            do {
                member = try MemberUser.decode(json: memberJSON)
            } catch {
                throw DecodeError.custom(error.localizedDescription)
            }
            members.append(member)
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

        return Members(
            members: members,
            page: page,
            prevPage: dictionary["prev_page"] as? UInt,
            nextPage: dictionary["next_page"] as? UInt,
            maxPerPage: maxPerPage,
            totalCount: totalCount
        )
    }
}
