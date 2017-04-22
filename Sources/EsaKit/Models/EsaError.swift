//
//  EsaError.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

/// An error from the API.
public struct EsaError: Error, AutoEquatable, AutoHashable {
    public let error: String
    public let message: String

    enum Key: String {
        case error
        case message
    }

    public init(error: String, message: String = "") {
        self.error = error
        self.message = message
    }
}

extension EsaError: CustomStringConvertible {
    public var description: String {
        return message
    }
}

extension EsaError: Decodable {
    public static func decode(json: Any) throws -> EsaError {
        guard let dictionary = json as? [String: Any] else {
            throw DecodeError.invalidFormat(json: json)
        }

        guard let error = dictionary[Key.error.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.error.rawValue, actualValue: dictionary[Key.error.rawValue])
        }

        guard let message = dictionary[Key.message.rawValue] as? String else {
            throw DecodeError.missingValue(key: Key.message.rawValue, actualValue: dictionary[Key.message.rawValue])
        }

        return EsaError(
            error: error,
            message: message
        )
    }
}
