//
//  Response.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/23.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

let LinksRegex = try! NSRegularExpression(pattern: "(?<=\\A|,) *<([^>]+)>( *; *\\w+ *= *\"[^\"]+\")* *(?=\\z|,)", options: [])
let LinkParamRegex = try! NSRegularExpression(pattern: "; *(\\w+) *= *\"([^\"]+)\"", options: [])

/// Returns any links, keyed by `rel`, from the RFC 5988 link header.
private func linksInLinkHeader(_ header: NSString) -> [String: URL] {
    var links: [String: URL] = [:]
    for match in LinksRegex.matches(in: header as String, options: [], range: NSMakeRange(0, header.length)) {
        let URI = header.substring(with: match.rangeAt(1))
        let params = header.substring(with: match.rangeAt(2)) as NSString
        guard let url = URL(string: URI) else { continue }

        var relName: String? = nil
        for match in LinkParamRegex.matches(in: params as String, options: [], range: NSMakeRange(0, params.length)) {
            let name = params.substring(with: match.rangeAt(1))
            if name != "rel" { continue }

            relName = params.substring(with: match.rangeAt(2))
        }

        if let relName = relName {
            links[relName] = url
        }
    }
    return links
}


/// A response from the esa.io API.
public struct Response {
    /// The number of requests remaining in the current rate limit window, or nil if the server
    /// isn't rate-limited.
    public let rateLimitRemaining: UInt?

    /// The time at which the current rate limit window resets, or nil if the server isn't
    /// rate-limited.
    public let rateLimitReset: Date?

    /// Any links that are included in the response.
    public let links: [String: URL]

    public init(rateLimitRemaining: UInt, rateLimitReset: Date, links: [String: URL]) {
        self.rateLimitRemaining = rateLimitRemaining
        self.rateLimitReset = rateLimitReset
        self.links = links
    }

    /// Initialize a response with HTTP header fields.
    internal init(headerFields: [String : String]) {
        self.rateLimitRemaining = headerFields["X-RateLimit-Remaining"].flatMap { UInt($0) }
        self.rateLimitReset = headerFields["X-RateLimit-Reset"]
            .flatMap { TimeInterval($0) }
            .map { Date(timeIntervalSince1970: $0) }
        self.links = linksInLinkHeader(headerFields["Link"] as NSString? ?? "")
    }
}

extension Response: Hashable {
    public static func ==(lhs: Response, rhs: Response) -> Bool {
        return lhs.rateLimitRemaining == rhs.rateLimitRemaining
            && lhs.rateLimitReset == rhs.rateLimitReset
            && lhs.links == rhs.links
    }

    public var hashValue: Int {
        return (rateLimitRemaining?.hashValue ?? 0)
            ^ (rateLimitReset?.hashValue ?? 0)
            ^ Array(links.values).reduce(0) { $0 ^ $1.hashValue }
    }
}
