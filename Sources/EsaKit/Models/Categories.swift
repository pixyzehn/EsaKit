//
//  Categories.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/03/02.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

public struct Categories: AutoEquatable, AutoHashable {
    public let count: Int
    public let from: String
    public let to: String
}

extension Categories: Decodable {
    public static func decode(_ e: Extractor) throws -> Categories {
        return try Categories(
            count: e <| "count",
            from: e <| "from",
            to: e <| "to"
        )
    }
}
