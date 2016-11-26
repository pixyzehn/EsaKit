//
//  BodyParameters.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct PostParameters {
    let name: String
    let bodyMd: String = ""
    let tags: [String] = [""]
    let category: String = ""
    let wip: Bool = true
    let message: String = ""
}

public struct TokenParameters {
    let clientId: String
    let clientSecret: String
    let code: String
    let redirectURI: String
}
