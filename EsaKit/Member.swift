//
//  Member.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Member: Decodable {
    public let name: String
    public let screenName: String
    public let icon: String
    public let email: String
    public let postsCount: Int

    public static func decode(_ e: Extractor) throws -> Member {
        return try Member(
            name: e <| "name",
            screenName: e <| "screen_name",
            icon: e <| "icon",
            email: e <| "email",
            postsCount: e <| "posts_count"
        )
    }
}
