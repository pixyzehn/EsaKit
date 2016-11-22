//
//  Team.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

struct Team: Decodable {
    let name: String
    let privacy: String
    let description: String
    let icon: String
    let url: String

    static func decode(_ e: Extractor) throws -> Team {
        return try Team(
            name: e <| "name",
            privacy: e <| "privacy",
            description: e <| "description",
            icon: e <| "icon",
            url: e <| "url"
        )
    }
}
