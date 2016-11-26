//
//  Response.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/23.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

/// A response from the esa.io API.
public struct Response {
    public let xRateLimitLimit: UInt
    public let XRateLimitRemaining: UInt

    public init(xRateLimitLimit: UInt, XRateLimitRemaining: UInt) {
        self.xRateLimitLimit = xRateLimitLimit
        self.XRateLimitRemaining = XRateLimitRemaining
    }

    /// Initialize a response with HTTP header fields.
    internal init(headerFields: [String : String]) {
        xRateLimitLimit = headerFields["X-RateLimit-Limit"].flatMap { UInt($0) } ?? 0
        XRateLimitRemaining = headerFields["X-RateLimit-Remaining"].flatMap { UInt($0) } ?? 0
    }
}

extension Response: Hashable {
    public static func ==(lhs: Response, rhs: Response) -> Bool {
        return lhs.xRateLimitLimit == rhs.xRateLimitLimit
            && lhs.XRateLimitRemaining == rhs.XRateLimitRemaining
    }

    public var hashValue: Int {
        return (xRateLimitLimit.hashValue)
            ^ (XRateLimitRemaining.hashValue)
    }
}
