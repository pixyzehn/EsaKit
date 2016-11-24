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

    internal init(_ endpoint: EsaClient.Endpoint, page: UInt = 0, pageSize: UInt = 0) {
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
    internal static func create(_ url: URL, _ endpoint: EsaClient.Endpoint, _ credentials: EsaClient.Credentials?, contentType: String? = EsaClient.APIContentType) -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        if let credentials = credentials {
            request.setValue(credentials.authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        return request
    }
}

extension HTTPURLResponse {
    enum StatusCodeType: Int {
        case ok = 200
        case created = 201
        case noContent = 204
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case tooManyRequests = 429
        case internalServerError = 500
        case unknown = 0
    }

    var statusCodeType: StatusCodeType {
        return StatusCodeType(rawValue: statusCode) ?? .unknown
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
        case apiError(Int, Response, EsaError)

        /// The requested object does not exist.
        case doesNotExist
    }

    /// Credentials for the esa.io API.
    internal enum Credentials {
        case token(String)

        var authorizationHeader: String {
            switch self {
            case let .token(token):
                return "Bearer \(token)"
            }
        }
    }

    /// An esa.io API endpoint.
    public enum Endpoint {
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
        case members(teamName: String)

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
        case watchers(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-2-0
        case addWatch(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-3-0
        case deleteWatch(teamName: String, postNumber: Int)

        /// - User
        /// https://docs.esa.io/posts/102#11-1-0
        case user

        var method: HTTPMethod {
            switch self {
            /// - OAuth
            case .oauthAuthorize:
                return .get
            case .oauthToken:
                return .post
            case .oaauthTokenInfo:
                return .get
            case .oauthRevoke:
                return .post

            /// - Team
            case .teams:
                return .get
            case .team(_):
                return .get

            /// - Stats
            case .teamStats(_):
                return .get

            /// - Member
            case .members(_):
                return .get

            /// - Post
            case .posts(_):
                return .get
            case .post(_, _):
                return .get
            case .createPost(_):
                return .post
            case .updatePost(_, _):
                return .patch
            case .deletePost(_, _):
                return .delete

            /// - Comment
            case .comments(_, _):
                return .get
            case .comment(_, _):
                return .get
            case .createComment(_, _):
                return .post
            case .updateComment(_, _):
                return .patch
            case .deleteComment(_, _):
                return .delete

            /// - Star
            case .stargazersInPost(_, _):
                return .get
            case .addStarInPost(_, _):
                return .post
            case .removeStarInPost(_, _):
                return .delete
            case .stargazersInComment(_, _):
                return .get
            case .addStarInComment(_, _):
                return .post
            case .removeStarInComment(_, _):
                return .delete

            /// - Watch
            case .watchers(_, _):
                return .get
            case .addWatch(_, _):
                return .post
            case .deleteWatch(_, _):
                return .delete

            /// - User
            case .user:
                return .get
            }
        }

        internal var path: String {
            switch self {
            /// - OAuth
            case .oauthAuthorize:
                return "/oauth/authorize"
            case .oauthToken:
                return "/oauth/token"
            case .oaauthTokenInfo:
                return "/oauth/token/info"
            case .oauthRevoke:
                return "/oauth/revoke"

            /// - Team
            case .teams:
                return "/v1/teams"
            case let .team(teamName):
                return "/v1/teams/\(teamName)"

            /// - Stats
            case let .teamStats(teamName):
                return "/v1/teams/\(teamName)/stats"

            /// - Member
            case let .members(teamName):
                return "/v1/teams/\(teamName)/members"

            /// - Post
            case let .posts(teamName):
                return "/v1/teams/\(teamName)/posts"
            case let .post(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"
            case let .createPost(teamName):
                return "/v1/teams/\(teamName)/posts"
            case let .updatePost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"
            case let .deletePost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"

            /// - Comment
            case let .comments(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/comments"
            case let .comment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)"
            case let .createComment(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/comments"
            case let .updateComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)"
            case let .deleteComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)"

            /// - Star
            case let .stargazersInPost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/stargazers"
            case let .addStarInPost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/star"
            case let .removeStarInPost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/star"
            case let .stargazersInComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)/stargazers"
            case let .addStarInComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)/star"
            case let .removeStarInComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)/star"

            /// - Watch
            case let .watchers(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watchers"
            case let .addWatch(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watch"
            case let .deleteWatch(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watch"

            /// - User
            case .user:
                return "/v1/user"
            }
        }

        internal var queryItems: [URLQueryItem] {
            return []
        }
    }

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

    /// Create an authenticated client for the given Server with a token.
    public init(token: String, urlSession: URLSession = .shared) {
        self.server = Server()
        self.credentials = .token(token)
        self.urlSession = urlSession
    }

    /// Esa APIs

    public func request(endpoint: Endpoint) -> SignalProducer<(Response, Members), Error> {
        let url = URL(endpoint)
        let request = URLRequest.create(url, endpoint, credentials)
        return urlSession
            .reactive
            .data(with: request)
            .mapError(Error.networkError)
            .flatMap(.concat) { data, response -> SignalProducer<(Response, Members), Error> in
                let response = response as! HTTPURLResponse
                let headers = response.allHeaderFields as! [String:String]
                return SignalProducer
                    .attempt {
                        return JSONSerialization.deserializeJSON(data).mapError(Error.jsonDeserializationError)
                    }
                    .attemptMap { JSON in
                        if response.statusCode == 404 {
                            return .failure(.doesNotExist)
                        }
                        if response.statusCode >= 400 && response.statusCode < 600 {
                            return .failure(.jsonDecodingError(DecodeError.custom("Error by statusCode")))
                        }

                        do {
                            let members = try Members.decodeValue(JSON)
                            return .success(members)
                        } catch let error as DecodeError {
                            return .failure(.jsonDecodingError(DecodeError.custom("Error by decodeValue \(error.description)")))
                        } catch {
                            return .failure(.jsonDecodingError(DecodeError.custom("Error by decodeValue")))
                        }
                    }
                    .map { JSON in
                        return (Response(headerFields: headers), JSON)
                    }
            }
    }
}
