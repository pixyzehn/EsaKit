//
//  EsaClient.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/19.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Argo
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

    internal init(_ endpoint: EsaClient.Endpoint, server: Server = .dotIo, page: UInt? = nil, pageSize: UInt? = nil) {
        let queryItems = [ ("page", page), ("per_page", pageSize) ]
            .filter { _, value in value != nil }
            .map { name, value in URLQueryItem(name: name, value: "\(value!)") }

        let url = URL(string: server.endpoint)!
            .appendingPathComponent(endpoint.path)
            .url(with: endpoint.queryItems)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}

/// An esa.io API Client
public final class EsaClient {

    /// An esa.io API endpoint.
    internal enum Endpoint {
        /// - OAuth
        /// https://docs.esa.io/posts/102#3-3-3
        case oauthToken
        /// https://docs.esa.io/posts/102#3-3-4
        case oauthTokenInfo
        /// https://docs.esa.io/posts/102#3-3-5
        case revokeOauth

        /// - Team
        /// https://docs.esa.io/posts/102#4-0-0
        case teamsList
        /// https://docs.esa.io/posts/102#4-2-0
        case teamInfo(teamName: String)

        /// - Stats
        /// https://docs.esa.io/posts/102#5-1-0
        case teamStats(teamName: String)

        /// - Member
        /// https://docs.esa.io/posts/102#6-1-0
        case membersList

        /// - Post
        /// https://docs.esa.io/posts/102#7-1-0
        case postList(teamName: String)
        /// https://docs.esa.io/posts/102#7-2-0
        case postInfo(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#7-3-0
        case post(teamName: String)
        /// https://docs.esa.io/posts/102#7-4-0
        case updatePost(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#7-5-0
        case deletePost(teamName: String, postNumber: Int)

        /// - Comment
        /// https://docs.esa.io/posts/102#8-1-0
        case commentList(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#8-2-0
        case commentInfo(teamName: String, commentId: Int)
        /// https://docs.esa.io/posts/102#8-3-0
        case comment(teamName: String, postNumber: Int)
        /// https://docs.esa.io/posts/102#8-4-0
        case updateComment(teamName: String, commentId: Int)

        internal var path: String {
            return ""
        }

        internal var queryItems: [URLQueryItem] {
            return []
        }
    }
}
