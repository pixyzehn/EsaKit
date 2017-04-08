//
//  Response.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/23.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Response: AutoEquatable, AutoHashable {
    public let xRateLimitLimit: UInt // An esa.io API allows user to send 75 requests per 15 min.
    public let xRateLimitRemaining: UInt
    public let xRateLimitReset: UInt

    public init(xRateLimitLimit: UInt, xRateLimitRemaining: UInt, xRateLimitReset: UInt) {
        self.xRateLimitLimit = xRateLimitLimit
        self.xRateLimitRemaining = xRateLimitRemaining
        self.xRateLimitReset = xRateLimitReset
    }

    internal init(headerFields: [String: String]) {
        xRateLimitLimit = headerFields["X-RateLimit-Limit"].flatMap { UInt($0) } ?? 0
        xRateLimitRemaining = headerFields["X-RateLimit-Remaining"].flatMap { UInt($0) } ?? 0
        xRateLimitReset = headerFields["X-RateLimit-Reset"].flatMap { UInt($0) } ?? 0
    }
}
