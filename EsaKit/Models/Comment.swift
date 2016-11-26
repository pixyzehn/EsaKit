//
//  Comment.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Comment: Decodable {
    public let id: Int
    public let bodyMd: String
    public let bodyHtml: String
    public let createdAt: String
    public let updatedAt: String
    public let url: String
    public let createdBy: MinimumUser
    public let stargazersCount: Int
    public let star: Bool

    public static func decode(_ e: Extractor) throws -> Comment {
        return try Comment(
            id: e <| "id",
            bodyMd: e <| "body_md",
            bodyHtml: e <| "body_html",
            createdAt: e <| "created_at",
            updatedAt: e <| "updated_at",
            url: e <| "url",
            createdBy: e <| "created_by",
            stargazersCount: e <| "stargazers_count",
            star: e <| "star"
        )
    }
}
