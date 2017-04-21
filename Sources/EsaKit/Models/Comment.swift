//
//  Comment.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Comment: AutoEquatable, AutoHashable {
    public let id: Int
    public let bodyMd: String
    public let bodyHTML: String
    public let createdAt: Date
    public let updatedAt: Date
    public let url: URL
    public let createdBy: MinimumUser
    public let stargazersCount: UInt
    public let star: Bool

    enum Key: String {
        case id
        case bodyMd = "body_md"
        case bodyHTML = "body_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
        case createdBy = "created_by"
        case stargazersCount = "stargazers_count"
        case star
    }
}

extension Comment: Decodable {
    // swiftlint:disable line_length
    public static func decode(json: Any) throws -> Comment {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let id = dictionary[Key.id.rawValue] as? Int else {
            throw DecodeError.missingValue(key: Key.id.rawValue, actualValue: dictionary[Key.id.rawValue])
        }

        guard let bodyMd = dictionary[Key.bodyMd.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.bodyMd.rawValue, actualValue: dictionary[Key.bodyMd.rawValue])
        }

        guard let bodyHTML = dictionary[Key.bodyHTML.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.bodyHTML.rawValue, actualValue: dictionary[Key.bodyHTML.rawValue])
        }

        guard let createdAtString = dictionary[Key.createdAt.rawValue] as? String,
              let createdAt = DateFormatter.iso8601.date(from: createdAtString) else {
            throw DecodeError.missingValue(key: Key.createdAt.rawValue, actualValue: dictionary[Key.createdAt.rawValue])
        }

        guard let updatedAtString = dictionary[Key.updatedAt.rawValue] as? String,
              let updatedAt = DateFormatter.iso8601.date(from: updatedAtString) else {
            throw DecodeError.missingValue(key: Key.updatedAt.rawValue, actualValue: dictionary[Key.updatedAt.rawValue])
        }

        guard let urlString = dictionary[Key.url.rawValue] as? String,
              let url = URL(string: urlString) else {
            throw DecodeError.missingValue(key: Key.url.rawValue, actualValue: dictionary[Key.url.rawValue])
        }

        guard let createdByJSON = dictionary[Key.createdBy.rawValue] else {
            throw DecodeError.missingValue(key: Key.createdBy.rawValue, actualValue: dictionary[Key.createdBy.rawValue])
        }
        let createdBy: MinimumUser
        do {
            createdBy = try MinimumUser.decode(json: createdByJSON)
        } catch {
            throw DecodeError.custom(error.localizedDescription)
        }

        guard let stargazersCount = dictionary[Key.stargazersCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.stargazersCount.rawValue, actualValue: dictionary[Key.stargazersCount.rawValue])
        }

        guard let star = dictionary[Key.star.rawValue] as? Bool else {
            throw DecodeError.missingValue(key: Key.star.rawValue, actualValue: dictionary[Key.star.rawValue])
        }

        return Comment(
            id: id,
            bodyMd: bodyMd,
            bodyHTML: bodyHTML,
            createdAt: createdAt,
            updatedAt: updatedAt,
            url: url,
            createdBy: createdBy,
            stargazersCount: stargazersCount,
            star: star
        )
    }
}
