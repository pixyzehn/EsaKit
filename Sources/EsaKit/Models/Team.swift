//
//  Team.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Team: Decodable {
    public let name: String
    public let privacy: String
    public let description: String
    public let icon: URL
    public let url: URL

    public static func decode(_ e: Extractor) throws -> Team {
        return try Team(
            name: e <| "name",
            privacy: e <| "privacy",
            description: e <| "description",
            icon: try Transformer { try toURL($0) }.apply(e <| "icon"),
            url: try Transformer { try toURL($0) }.apply(e <| "url")
        )
    }
}

extension Team: Hashable {
    public static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name
            && lhs.privacy == rhs.privacy
            && lhs.url == rhs.url
            && lhs.description == rhs.description
            && lhs.icon == rhs.icon
            && lhs.url == rhs.url
    }

    public var hashValue: Int {
        return name.hashValue
    }
}
