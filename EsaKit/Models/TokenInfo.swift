//
//  TokenInfo.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct TokenInfo: Decodable {
    public let resourceOwnerId: Int
    public let scopes: [String]
    public let expiresInSeconds: Double?
    public let applicationUID: String
    public let createdAt: Date

    public static func decode(_ e: Extractor) throws -> TokenInfo {
        return try TokenInfo(
            resourceOwnerId: e <| "resource_owner_id",
            scopes: e <|| "scopes",
            expiresInSeconds: e <|? "expires_in_seconds",
            applicationUID: e <| ["application", "uid"],
            createdAt: try Transformer { Date.init(timeIntervalSince1970: $0) }.apply(e <| "created_at")
        )
    }
}
