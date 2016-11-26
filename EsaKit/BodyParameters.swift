//
//  BodyParameters.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct PostParameters {
    public init(
        name: String,
        bodyMd: String = "",
        tags: [String] = [],
        category: String? = nil,
        wip: Bool = true,
        message: String = ""
    ) {
        self.name = name
        self.bodyMd = bodyMd
        self.tags = tags
        self.category = category
        self.wip = wip
        self.message = message
    }
    public let name: String
    public let bodyMd: String
    public let tags: [String]
    public let category: String?
    public let wip: Bool
    public let message: String
}

public struct TokenParameters {
    public init(
        clientId: String,
        clientSecret: String,
        code: String,
        redirectURI: String
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.code = code
        self.redirectURI = redirectURI
    }
    public let clientId: String
    public let clientSecret: String
    public let code: String
    public let redirectURI: String
}

public struct TokenRevokeParameters {
    public init(
        clientId: String,
        clientSecret: String,
        token: String
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.token = token
    }
    public let clientId: String
    public let clientSecret: String
    public let token: String
}
