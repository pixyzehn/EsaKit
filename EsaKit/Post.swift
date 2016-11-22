//
//  Post.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Post: Decodable {
    let number: Int
    let name: String
    let fullName: String
    let wip: Bool
    let bodyMd: String
    let bodyHtml: String
    let createdAt: String
    let updatedAt: String
    let message: String
    let url: String
    let tags: [String]
    let category: String
    let revisionNumber: Int
    let createdBy: User
    let updatedBy: User
    let kind: String
    let commentsCount: Int
    let tasksCount: Int
    let doneTasksCount: Int
    let stargazersCount: Int
    let watchersCount: Int
    let star: Bool
    let watch: Bool

    static func decode(_ e: Extractor) throws -> Post {
        return try Post(
            number: e <| "number",
            name: e <| "name",
            fullName: e <| "full_name",
            wip: e <| "wip",
            bodyMd: e <| "body_md",
            bodyHtml: e <| "body_html",
            createdAt: e <| "created_at",
            updatedAt: e <| "updated_at",
            message: e <| "message",
            url: e <| "url",
            tags: e <|| "tags",
            category: e <| "category",
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
