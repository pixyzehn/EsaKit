//
//  Categories.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/03/02.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Categories: Decodable {
    public let count: Int
    public let from: String
    public let to: String

    public static func decode(_ e: Extractor) throws -> Categories {
        return try Categories(
            count: e <| "count",
            from: e <| "from",
            to: e <| "to"
        )
    }
}

extension Categories: Hashable {
    public static func ==(lhs: Categories, rhs: Categories) -> Bool {
        return lhs.count == rhs.count
            && lhs.from == rhs.from
            && lhs.to == rhs.to
    }

    public var hashValue: Int {
        return from.hashValue
    }
}
