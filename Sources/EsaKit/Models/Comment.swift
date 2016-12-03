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
    public let bodyHTML: String
    public let createdAt: Date
    public let updatedAt: Date
    public let url: URL
    public let createdBy: MinimumUser
    public let stargazersCount: UInt
    public let star: Bool

    public static func decode(_ e: Extractor) throws -> Comment {
        return try Comment(
            id: e <| "id",
            bodyMd: e <| "body_md",
            bodyHTML: e <| "body_html",
            createdAt: try Transformer { try toDate($0) }.apply(e <| "created_at"),
            updatedAt: try Transformer { try toDate($0) }.apply(e <| "updated_at"),
            url: Transformer { try toURL($0) }.apply(e <| "url"),
            createdBy: e <| "created_by",
            stargazersCount: e <| "stargazers_count",
            star: e <| "star"
        )
    }
}

extension Comment: Hashable {
    public static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
            && lhs.bodyMd == rhs.bodyMd
            && lhs.bodyHTML == rhs.bodyHTML
            && lhs.createdAt == rhs.createdAt
            && lhs.updatedAt == rhs.updatedAt
            && lhs.url == rhs.url
            && lhs.createdBy == rhs.createdBy
            && lhs.stargazersCount == rhs.stargazersCount
            && lhs.star == rhs.star
    }

    public var hashValue: Int {
        return id.hashValue
    }
}