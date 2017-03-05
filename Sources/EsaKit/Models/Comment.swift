//
//  Comment.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Comment: Decodable, AutoEquatable, AutoHashable {
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
