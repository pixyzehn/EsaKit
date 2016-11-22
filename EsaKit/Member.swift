//
//  Member.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Member: Decodable {
    let name: String
    let screenName: String
    let icon: String
    let email: String
    let postsCount: Int

    static func decode(_ e: Extractor) throws -> Member {
        return try Member(
            name: e <| "name",
            screenName: e <| "screen_name",
            icon: e <| "icon",
            email: e <| "email",
            postsCount: e <| "posts_count"
        )
    }
}
