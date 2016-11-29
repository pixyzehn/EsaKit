//
//  Response.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/23.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public struct Response {
    public let xRateLimitLimit: UInt // An esa.io API allows user to send 75 requests per 15 min.
    public let XRateLimitRemaining: UInt

    public init(xRateLimitLimit: UInt, XRateLimitRemaining: UInt) {
        self.xRateLimitLimit = xRateLimitLimit
        self.XRateLimitRemaining = XRateLimitRemaining
    }

    internal init(headerFields: [String: String]) {
        xRateLimitLimit = headerFields["X-RateLimit-Limit"].flatMap { UInt($0) } ?? 0
        XRateLimitRemaining = headerFields["X-RateLimit-Remaining"].flatMap { UInt($0) } ?? 0
    }
}
