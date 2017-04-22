//
//  Post.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Post: AutoEquatable, AutoHashable {
    public let number: Int
    public let name: String
    public let fullName: String
    public let wip: Bool
    public let bodyMd: String
    public let bodyHTML: String
    public let createdAt: Date
    public let updatedAt: Date
    public let message: String
    public let url: URL
    public let tags: [String]
    public let category: String?
    public let revisionNumber: Int
    public let createdBy: MinimumUser
    public let updatedBy: MinimumUser
    public let kind: String
    public let commentsCount: UInt
    public let tasksCount: UInt
    public let doneTasksCount: UInt
    public let stargazersCount: UInt
    public let watchersCount: UInt
    public let star: Bool
    public let watch: Bool

    enum Key: String {
        case number
        case name
        case fullName = "full_name"
        case wip
        case bodyMd = "body_md"
        case bodyHTML = "body_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case message
        case url
        case tags
        case category
        case revisionNumber = "revision_number"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case kind
        case commentsCount = "comments_count"
        case tasksCount = "tasks_count"
        case doneTasksCount = "done_tasks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case star
        case watch
    }
}

extension Post: Decodable {
    // swiftlint:disable cyclomatic_complexity function_body_length line_length
    public static func decode(json: Any) throws -> Post {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let number = dictionary[Key.number.rawValue] as? Int else {
            throw DecodeError.missingValue(key: Key.number.rawValue, actualValue: dictionary[Key.number.rawValue])
        }

        guard let name = dictionary[Key.name.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.name.rawValue, actualValue: dictionary[Key.name.rawValue])
        }

        guard let fullName = dictionary[Key.fullName.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.fullName.rawValue, actualValue: dictionary[Key.fullName.rawValue])
        }

        guard let wip = dictionary[Key.wip.rawValue] as? Bool else {
            throw DecodeError.missingValue(key: Key.wip.rawValue, actualValue: dictionary[Key.wip.rawValue])
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

        guard let message = dictionary[Key.message.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.message.rawValue, actualValue: dictionary[Key.message.rawValue])
        }

        guard let urlString = dictionary[Key.url.rawValue] as? String,
              let url = URL(string: urlString) else {
            throw DecodeError.missingValue(key: Key.url.rawValue, actualValue: dictionary[Key.url.rawValue])
        }

        guard let tags = dictionary[Key.tags.rawValue] as? [String] else {
            throw DecodeError.missingValue(key: Key.tags.rawValue, actualValue: dictionary[Key.tags.rawValue])
        }

        guard let revisionNumber = dictionary[Key.revisionNumber.rawValue] as? Int else {
            throw DecodeError.missingValue(key: Key.revisionNumber.rawValue, actualValue: dictionary[Key.revisionNumber.rawValue])
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

        guard let updatedByJSON = dictionary[Key.updatedBy.rawValue] else {
            throw DecodeError.missingValue(key: Key.updatedBy.rawValue, actualValue: dictionary[Key.updatedBy.rawValue])
        }
        let updatedBy: MinimumUser
        do {
            updatedBy = try MinimumUser.decode(json: updatedByJSON)
        } catch {
            throw DecodeError.custom(error.localizedDescription)
        }

        guard let kind = dictionary[Key.kind.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.kind.rawValue, actualValue: dictionary[Key.kind.rawValue])
        }

        guard let commentsCount = dictionary[Key.commentsCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.commentsCount.rawValue, actualValue: dictionary[Key.commentsCount.rawValue])
        }

        guard let tasksCount = dictionary[Key.tasksCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.tasksCount.rawValue, actualValue: dictionary[Key.tasksCount.rawValue])
        }

        guard let doneTasksCount = dictionary[Key.doneTasksCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.doneTasksCount.rawValue, actualValue: dictionary[Key.doneTasksCount.rawValue])
        }

        guard let stargazersCount = dictionary[Key.stargazersCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.stargazersCount.rawValue, actualValue: dictionary[Key.stargazersCount.rawValue])
        }

        guard let watchersCount = dictionary[Key.watchersCount.rawValue] as? UInt else {
            throw DecodeError.missingValue(key: Key.watchersCount.rawValue, actualValue: dictionary[Key.watchersCount.rawValue])
        }

        guard let star = dictionary[Key.star.rawValue] as? Bool else {
            throw DecodeError.missingValue(key: Key.star.rawValue, actualValue: dictionary[Key.star.rawValue])
        }

        guard let watch = dictionary[Key.watch.rawValue] as? Bool else {
            throw DecodeError.missingValue(key: Key.watch.rawValue, actualValue: dictionary[Key.watch.rawValue])
        }

        return Post(
            number: number,
            name: name,
            fullName: fullName,
            wip: wip,
            bodyMd: bodyMd,
            bodyHTML: bodyHTML,
            createdAt: createdAt,
            updatedAt: updatedAt,
            message: message,
            url: url,
            tags: tags,
            category: dictionary[Key.category.rawValue] as? String,
            revisionNumber: revisionNumber,
            createdBy: createdBy,
            updatedBy: updatedBy,
            kind: kind,
            commentsCount: commentsCount,
            tasksCount: tasksCount,
            doneTasksCount: doneTasksCount,
            stargazersCount: stargazersCount,
            watchersCount: watchersCount,
            star: star,
            watch: watch
        )
    }
}
