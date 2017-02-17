//
//  Post.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Post: Decodable {
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

    public static func decode(_ e: Extractor) throws -> Post {
        return try Post(
            number: e <| "number",
            name: e <| "name",
            fullName: e <| "full_name",
            wip: e <| "wip",
            bodyMd: e <| "body_md",
            bodyHTML: e <| "body_html",
            createdAt: try Transformer { try toDate($0) }.apply(e <| "created_at"),
            updatedAt: try Transformer { try toDate($0) }.apply(e <| "updated_at"),
            message: e <| "message",
            url: try Transformer { try toURL($0) }.apply(e <| "url"),
            tags: e <|| "tags",
            category: e <|? "category",
            revisionNumber: e <| "revision_number",
            createdBy: e <| "created_by",
            updatedBy: e <| "updated_by",
            kind: e <| "kind",
            commentsCount: e <| "comments_count",
            tasksCount: e <| "tasks_count",
            doneTasksCount: e <| "done_tasks_count",
            stargazersCount: e <| "stargazers_count",
            watchersCount: e <| "watchers_count",
            star: e <| "star",
            watch: e <| "watch"
        )
    }
}

extension Post: Hashable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        // NOTE: If you use all paramters, xcodebuild fails.
        // It needs more investigation.
        return lhs.number == rhs.number
            && lhs.name == rhs.name
            && lhs.fullName == rhs.fullName
            && lhs.wip == rhs.wip
//            && lhs.bodyMd == rhs.bodyMd
//            && lhs.bodyHTML == rhs.bodyHTML
//            && lhs.createdAt == rhs.createdAt
//            && lhs.updatedAt == rhs.updatedAt
//            && lhs.message == rhs.message
//            && lhs.url == rhs.url
//            && lhs.tags == rhs.tags
//            && lhs.category == rhs.category
//            && lhs.revisionNumber == rhs.revisionNumber
//            && lhs.createdBy == rhs.createdBy
//            && lhs.updatedBy == rhs.updatedBy
//            && lhs.kind == rhs.kind
//            && lhs.commentsCount == rhs.commentsCount
//            && lhs.tasksCount == rhs.tasksCount
//            && lhs.doneTasksCount == rhs.doneTasksCount
//            && lhs.stargazersCount == rhs.stargazersCount
//            && lhs.watchersCount == rhs.watchersCount
//            && lhs.star == rhs.star
//            && lhs.watch == rhs.watch
    }

    public var hashValue: Int {
        return name.hashValue
    }
}
