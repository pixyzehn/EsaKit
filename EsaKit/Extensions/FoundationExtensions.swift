//
//  FoundationExtensions.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Result

extension DateFormatter {
    @nonobjc internal static var iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(abbreviation:"UTC")
        return formatter
    }()
}

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
            .url(with: endpoint.queryParameters)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}

extension URLRequest {
    internal static func create(_ url: URL, _ endpoint: EsaClient.Endpoint, _ credentials: EsaClient.Credentials?, contentType: String? = EsaClient.APIContentType) -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        if let bodyParameters = endpoint.bodyParameters, !endpoint.method.prefersQueryParameters {
            let data = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            request.httpBody = data
        }

        if let credentials = credentials {
            request.setValue(credentials.authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        return request
    }
}

// An esa.io API uses 200 / 201 / 204 / 400 / 401 / 402 / 403 / 404 / 500.
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
