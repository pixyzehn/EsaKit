//
//  EsaClient.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/19.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki
import ReactiveSwift
import Result

extension JSONSerialization {
    internal static func deserializeJSON(_ data: Data) -> Result<Any, NSError> {
        return Result(try JSONSerialization.jsonObject(with: data, options: []))
    }
}

extension URL {
    internal func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }

    internal init(_ endpoint: EsaClient.Endpoint, page: UInt? = nil, pageSize: UInt? = nil) {
        let queryItems = [ ("page", page), ("per_page", pageSize) ]
            .filter { _, value in value != nil }
            .map { name, value in URLQueryItem(name: name, value: "\(value!)") }

        let url = URL(string: Server().endpoint)!
            .appendingPathComponent(endpoint.path)
            .url(with: endpoint.queryItems)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}

extension URLRequest {
    internal static func create(_ url: URL, _ credentials: EsaClient.Credentials?, contentType: String? = EsaClient.APIContentType) -> URLRequest {
        var request = URLRequest(url: url)

        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        if let credentials = credentials {
            request.setValue(credentials.authorizationHeader, forHTTPHeaderField: "Authorization: Bearer")
        }

        return request
    }
}

/// An esa.io API Client
public final class EsaClient {
    internal static let APIContentType = "application/json"

    /// An error from the Client.
    public enum Error: Swift.Error {
        /// An error occurred in a network operation.
        case networkError(NSError)

        /// An error occurred while deserializing JSON.
        case jsonDeserializationError(NSError)

        /// An error occurred while decoding JSON.
        case jsonDecodingError(DecodeError)

        /// A status code, response, and error that was returned from the API.
        case apiError(Int, EsaError)

        /// The requested object does not exist.
        case doesNotExist
    }

    /// Credentials for the esa.io API.
    internal enum Credentials {
        case token(String)

        var authorizationHeader: String {
            switch self {
            case let .token(token):
                return "Authorization: Bearer \(token)"
            }
        }
    }

    /// An esa.io API endpoint.
    internal enum Endpoint {
        /// - OAuth
        /// https://docs.esa.io/posts/102#3-3-2
        case oauthAuthorize
        /// https://docs.esa.io/posts/102#3-3-3
        case oauthToken
        /// https://docs.esa.io/posts/102#3-3-4
        case oaauthTokenInfo
        /// https://docs.esa.io/posts/102#3-3-5
        case oauthRevoke

        /// - Team
        /// https://docs.esa.io/posts/102#4-0-0
        case teams
        /// https://docs.esa.io/posts/102#4-2-0
        case team(teamName: String)

        /// - Stats
        /// https://docs.esa.io/posts/102#5-1-0
        case teamStats(teamName: String)

        /// - Member
        /// https://docs.esa.io/posts/102#6-1-0
        case members

        /// - Post
        /// https://docs.esa.io/posts/102#7-1-0
        case posts(teamName: String)
        /// https://docs.esa.io/posts/102#7-2-0
        case post(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#7-3-0
        case createPost(teamName: String)
        /// https://docs.esa.io/posts/102#7-4-0
        case updatePost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#7-5-0
        case deletePost(teamName: String, postNumber: Int)

        /// - Comment
        /// https://docs.esa.io/posts/102#8-1-0
        case comments(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#8-2-0
        case comment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#8-3-0
        case createComment(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#8-4-0
        case updateComment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#8-5-0
        case deleteComment(teamName: String, commentId: Int)

        /// - Star
        /// https://docs.esa.io/posts/102#9-1-0
        case stargazersInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#9-2-0
        case addStarInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#9-3-0
        case removeStarInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#9-4-0
        case stargazersInComment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#9-5-0
        case addStarInComment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#9-6-0
        case removeStarInComment(teamName: String, commentId: Int)

        /// - Watch
        /// https://docs.esa.io/posts/102#10-1-0
        case watchersInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-2-0
        case addWatchInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-3-0
        case deleteWatchInPost(teamName: String, postNumber: Int)

        /// - User
        /// https://docs.esa.io/posts/102#11-1-0
        case user

        internal var path: String {
            return ""
        }

        internal var queryItems: [URLQueryItem] {
            return []
        }
    }

    /// The user-agent to use for API requests.
    public static var userAgent: String?

    /// The Server that the Client connects to.
    public let server: Server

    /// Whether the Client is authenticated.
    public var authenticated: Bool {
        return credentials != nil
    }

    /// The Credentials for the API.
    private let credentials: Credentials?

    /// The `URLSession` instance to use.
    private let urlSession: URLSession

    /// Create an unauthenticated client for the given Server.
    public init(_ server: Server, urlSession: URLSession = .shared) {
        self.server = server
        self.credentials = nil
        self.urlSession = urlSession
    }

    /// Create an authenticated client for the given Server with a token.
    public init(_ server: Server, token: String, urlSession: URLSession = .shared) {
        self.server = server
        self.credentials = .token(token)
        self.urlSession = urlSession
    }

    // Esa APIs ... like fetch...
}
