//
//  MinimumUser.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct MinimumUser: Decodable {
    public let name: String
    public let screenName: String
    public let icon: URL

    public static func decode(_ e: Extractor) throws -> MinimumUser {
        return try MinimumUser(
            name: e <| "name",
            screenName: e <| "screen_name",
            icon: try Transformer { try toURL($0) }.apply(e <| "icon")
        )
    }
}

extension MinimumUser: Hashable {
    public static func == (lhs: MinimumUser, rhs: MinimumUser) -> Bool {
        return lhs.name == rhs.name
            && lhs.screenName == rhs.screenName
            && lhs.icon == rhs.icon
    }

    public var hashValue: Int {
        return name.hashValue
    }
}
