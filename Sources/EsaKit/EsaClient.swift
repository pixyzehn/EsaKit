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

/// An esa.io API Client.
public final class EsaClient {

    /// An error from the Client.
    public enum Error: Swift.Error {
        case networkError(NSError)
        case jsonDeserializationError(NSError)
        case jsonDecodingError(DecodeError)
        case apiError(Int, Response, EsaError)
        case doesNotExist
        case unknownError
    }

    /// Credentials for the API.
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
        case posts(teamName: String, query: String)
        /// https://docs.esa.io/posts/102#7-2-0
        case post(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#7-3-0
        case createPost(teamName: String, parameters: PostParameters)
        /// https://docs.esa.io/posts/102#7-4-0
        case updatePost(teamName: String, postNumber: Int, parameters: PostParameters)
        /// https://docs.esa.io/posts/102#7-5-0
        case deletePost(teamName: String, postNumber: Int)

        /// - Comment
        /// https://docs.esa.io/posts/102#8-1-0
        case comments(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#8-2-0
        case comment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#8-3-0
        case createComment(teamName: String, postNumber: Int, bodyMd: String)
        /// https://docs.esa.io/posts/102#8-4-0
        case updateComment(teamName: String, commentId: Int, bodyMd: String)
        /// https://docs.esa.io/posts/102#8-5-0
        case deleteComment(teamName: String, commentId: Int)

        /// - Star
        /// https://docs.esa.io/posts/102#9-1-0
        case stargazersInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#9-2-0
        case addStarInPost(teamName: String, postNumber: Int, body: String)
        /// https://docs.esa.io/posts/102#9-3-0
        case removeStarInPost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#9-4-0
        case stargazersInComment(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#9-5-0
        case addStarInComment(teamName: String, commentId: Int, body: String)
        /// https://docs.esa.io/posts/102#9-6-0
        case removeStarInComment(teamName: String, commentId: Int)

        /// - Watch
        /// https://docs.esa.io/posts/102#10-1-0
        case watchers(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-2-0
        case addWatch(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#10-3-0
        case removeWatch(teamName: String, postNumber: Int)

        /// - User
        /// https://docs.esa.io/posts/102#11-1-0
        case user

        var method: HTTPMethod {
            switch self {
            /// - Team
            case .teams, .team(_): return .get

            /// - Stats
            case .teamStats(_): return .get

            /// - Member
            case .members(_): return .get

            /// - Post
            case .posts(_, _), .post(_, _): return .get
            case .createPost(_, _): return .post
            case .updatePost(_, _, _): return .patch
            case .deletePost(_, _): return .delete

            /// - Comment
            case .comments(_, _), .comment(_, _): return .get
            case .createComment(_, _, _): return .post
            case .updateComment(_, _, _): return .patch
            case .deleteComment(_, _): return .delete

            /// - Star
            case .stargazersInPost(_, _), .stargazersInComment(_, _): return .get
            case .addStarInPost(_, _, _), .addStarInComment(_, _, _): return .post
            case .removeStarInPost(_, _), .removeStarInComment(_, _): return .delete

            /// - Watch
            case .watchers(_, _): return .get
            case .addWatch(_, _): return .post
            case .removeWatch(_, _): return .delete

            /// - User
            case .user: return .get
            }
        }

        internal var path: String {
            switch self {
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
            case let .posts(teamName, _):
                return "/v1/teams/\(teamName)/posts"
            case let .post(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"
            case let .createPost(teamName, _):
                return "/v1/teams/\(teamName)/posts"
            case let .updatePost(teamName, postNumber, _):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"
            case let .deletePost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)"

            /// - Comment
            case let .comments(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/comments"
            case let .comment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)"
            case let .createComment(teamName, postNumber, _):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/comments"
            case let .updateComment(teamName, commentId, _):
                return "/v1/teams/\(teamName)/comments/\(commentId)"
            case let .deleteComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)"

            /// - Star
            case let .stargazersInPost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/stargazers"
            case let .addStarInPost(teamName, postNumber, _):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/star"
            case let .removeStarInPost(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/star"
            case let .stargazersInComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)/stargazers"
            case let .addStarInComment(teamName, commentId, _):
                return "/v1/teams/\(teamName)/comments/\(commentId)/star"
            case let .removeStarInComment(teamName, commentId):
                return "/v1/teams/\(teamName)/comments/\(commentId)/star"

            /// - Watch
            case let .watchers(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watchers"
            case let .addWatch(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watch"
            case let .removeWatch(teamName, postNumber):
                return "/v1/teams/\(teamName)/posts/\(postNumber)/watch"

            /// - User
            case .user:
                return "/v1/user"
            }
        }

        internal var queryParameters: [URLQueryItem] {
            if case let .posts(_, query) = self {
                if query.isEmpty {
                    return []
                }
                return [URLQueryItem(name: "q", value: query)]
            }
            return []
        }

        internal var bodyParameters: Any? {
            switch self {
            case let .createPost(_, parameters), let .updatePost(_, _, parameters):
                return [
                    "post": [
                        "name": parameters.name,
                        "body_md": parameters.bodyMd,
                        "tags": parameters.tags,
                        "category": parameters.category ?? "",
                        "wip": parameters.wip,
                        "message": parameters.message
                    ]
                ]
            case let .createComment(_, _, bodyMd), let .updateComment(_, _, bodyMd):
                return [ "comment": [ "body_md": bodyMd ] ]
            case let .addStarInPost(_, _, body):
                return [ "body": body ]
            default:
                return nil
            }
        }
    }

    /// The Server that the Client connects to.
    public let server: Server

    /// The user-agent to use for API requests.
    public static var userAgent: String?

    /// The team name for the API. You can change the name in the middle.
    public var teamName: String

    /// Whether the Client is authenticated.
    public var authenticated: Bool {
        return credentials != nil
    }

    /// The Credentials for the API.
    private let credentials: Credentials?

    /// The Content type for the API.
    internal static let APIContentType = "application/json"

    /// The `URLSession` instance to use.
    private let urlSession: URLSession

    /// Create an authenticated client for the given Server with a token.
    public init(token: String, teamName: String, urlSession: URLSession = .shared) {
        self.server = Server()
        self.teamName = teamName
        self.credentials = .token(token)
        self.urlSession = urlSession
    }

    // MARK: The esa.io API public methods.

    /// - Team
    public func teams(page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Teams), Error> {
        return fetchMany(.teams, page: page, pageSize: pageSize)
    }

    public func team() -> SignalProducer<(Response, Team), Error> {
        return fetchOne(.team(teamName: teamName))
    }

    /// - Stats
    public func stats() -> SignalProducer<(Response, Stats), Error> {
        return fetchOne(.teamStats(teamName: teamName))
    }

    /// - Member
    public func members(page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Members), Error> {
        return fetchMany(.members(teamName: teamName), page: page, pageSize: pageSize)
    }

    /// - Post
    public func posts(page: UInt = 1, pageSize: UInt = 20, query: String = "") -> SignalProducer<(Response, Posts), Error> {
        return fetchMany(.posts(teamName: teamName, query: query), page: page, pageSize: pageSize)
    }

    public func post(postNumber: Int) -> SignalProducer<(Response, Post), Error> {
        return fetchOne(.post(teamName: teamName, postNumber: postNumber))
    }

    public func createPost(parameters: PostParameters) -> SignalProducer<(Response, Post), Error> {
        return fetchOne(.createPost(teamName: teamName, parameters: parameters))
    }

    public func updatePost(postNumber: Int, parameters: PostParameters) -> SignalProducer<(Response, Post), Error> {
        return fetchOne(.updatePost(teamName: teamName, postNumber: postNumber, parameters: parameters))
    }

    public func deletePost(postNumber: Int) -> SignalProducer<Response, Error> {
        return request(.deletePost(teamName: teamName, postNumber: postNumber))
    }

    /// - Comments
    public func comments(postNumber: Int, page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Comments), Error> {
        return fetchMany(.comments(teamName: teamName, postNumber: postNumber), page: page, pageSize: pageSize)
    }

    public func comment(commentId: Int) -> SignalProducer<(Response, Comment), Error> {
        return fetchOne(.comment(teamName: teamName, commentId: commentId))
    }

    public func createComment(postNumber: Int, bodyMd: String) -> SignalProducer<(Response, Comment), Error> {
        return fetchOne(.createComment(teamName: teamName, postNumber: postNumber, bodyMd: bodyMd))
    }

    public func updateComment(commentId: Int, bodyMd: String) -> SignalProducer<(Response, Comment), Error> {
        return fetchOne(.updateComment(teamName: teamName, commentId: commentId, bodyMd: bodyMd))
    }

    public func deleteCommet(commentId: Int) -> SignalProducer<Response, Error> {
        return request(.deleteComment(teamName: teamName, commentId: commentId))
    }

    /// - Star
    public func stargazers(postNumber: Int, page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Stargazers), Error> {
        return fetchMany(.stargazersInPost(teamName: teamName, postNumber: postNumber), page: page, pageSize: pageSize)
    }

    public func addStar(postNumber: Int, body: String = "") -> SignalProducer<Response, Error> {
        return request(.addStarInPost(teamName: teamName, postNumber: postNumber, body: body))
    }

    public func removeStar(postNumber: Int) -> SignalProducer<Response, Error> {
        return request(.removeStarInPost(teamName: teamName, postNumber: postNumber))
    }

    public func stargazers(commentId: Int, page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Stargazers), Error> {
        return fetchMany(.stargazersInComment(teamName: teamName, commentId: commentId), page: page, pageSize: pageSize)
    }

    public func addStar(commentId: Int, body: String = "") -> SignalProducer<Response, Error> {
        return request(.addStarInComment(teamName: teamName, commentId: commentId, body: body))
    }

    public func removeStar(commentId: Int) -> SignalProducer<Response, Error> {
        return request(.removeStarInComment(teamName: teamName, commentId: commentId))
    }

    /// - Watch
    public func watchers(postNumber: Int, page: UInt = 1, pageSize: UInt = 20) -> SignalProducer<(Response, Watchers), Error> {
        return fetchMany(.watchers(teamName: teamName, postNumber: postNumber), page: page, pageSize: pageSize)
    }

    public func addWatch(postNumber: Int) -> SignalProducer<Response, Error> {
        return request(.addWatch(teamName: teamName, postNumber: postNumber))
    }

    public func removeWatch(postNumber: Int) -> SignalProducer<Response, Error> {
        return request(.removeWatch(teamName: teamName, postNumber: postNumber))
    }

    /// - User
    public func user() -> SignalProducer<(Response, User), Error> {
        return fetchOne(.user)
    }

    // MARK: Methods for the API request.

    internal func request(_ endpoint: Endpoint) -> SignalProducer<Response, Error> {
        let url = URL(endpoint)
        let request = URLRequest.create(url, endpoint, credentials)
        return urlSession
            .reactive
            .data(with: request)
            .mapError(Error.networkError)
            .flatMap(.concat) { _, response -> SignalProducer<Response, Error> in
                let response = response as! HTTPURLResponse
                let statusCodeType = response.statusCodeType
                let headers = response.allHeaderFields as! [String: String]
                return SignalProducer
                    .attempt {
                        return Result(response)
                    }
                    .attemptMap { _ in
                        switch statusCodeType {
                        case .ok, .created, .noContent:
                            return .success(Response(headerFields: headers))
                        default:
                            return .failure(.apiError(response.statusCode, Response(headerFields: headers), EsaError(error: statusCodeType.description)))
                        }
                    }
            }
    }

    internal func fetchOne<T: Decodable>(_ endpoint: Endpoint) -> SignalProducer<(Response, T), Error> {
        return request(endpoint)
            .attemptMap { response, JSON in
                return decode(JSON)
                    .map { resource in
                        (response, resource)
                    }
                    .mapError(Error.jsonDecodingError)
            }
    }

    internal func fetchMany<T: Decodable>(_ endpoint: Endpoint, page: UInt?, pageSize: UInt?) -> SignalProducer<(Response, T), Error> {
        return request(endpoint, page: page, pageSize: pageSize)
            .attemptMap { response, JSON in
                return decode(JSON)
                    .map { resource in
                        (response, resource)
                    }
                    .mapError(Error.jsonDecodingError)
            }
    }

    // MARK: Private method

    private func request(_ endpoint: Endpoint, page: UInt? = nil, pageSize: UInt? = nil) -> SignalProducer<(Response, Any), Error> {
        let url = URL(endpoint, page: page, pageSize: pageSize)
        let request = URLRequest.create(url, endpoint, credentials)
        return urlSession
            .reactive
            .data(with: request)
            .mapError(Error.networkError)
            .flatMap(.concat) { data, response -> SignalProducer<(Response, Any), Error> in
                let response = response as! HTTPURLResponse
                let statusCodeType = response.statusCodeType
                let headers = response.allHeaderFields as! [String:String]
                return SignalProducer
                    .attempt {
                        return JSONSerialization.deserializeJSON(data).mapError(Error.jsonDeserializationError)
                    }
                    .attemptMap { JSON in
                        switch statusCodeType {
                        case .ok, .created, .noContent:
                            return .success(JSON)
                        default:
                            return decode(JSON)
                                .mapError(Error.jsonDecodingError)
                                .flatMap { error in
                                    .failure(Error.apiError(response.statusCode, Response(headerFields: headers), error))
                                }
                        }
                    }
                    .map { JSON in
                        return (Response(headerFields: headers), JSON)
                    }
            }
    }
}
