//
//  Token.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Token: Decodable {
    public let accessToken: String
    public let tokenType: String
    public let scope: String
    public let createdAt: Date

    public static func decode(_ e: Extractor) throws -> Token {
        return try Token(
            accessToken: e <| "access_token",
            tokenType: e <| "token_type",
            scope: e <| "scope",
            createdAt: try Transformer { Date.init(timeIntervalSince1970: $0) }.apply(e <| "created_at")
        )
    }
}
