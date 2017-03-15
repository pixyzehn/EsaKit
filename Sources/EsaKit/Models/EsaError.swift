//
//  EsaError.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki

/// An error from the API.
public struct EsaError: CustomStringConvertible, Error, AutoEquatable, AutoHashable {
    public let error: String
    public let message: String

    public var description: String {
        return message
    }

    public init(error: String, message: String = "") {
        self.error = error
        self.message = message
    }
}

extension EsaError: Decodable {
    public static func decode(_ e: Extractor) throws -> EsaError {
        return try EsaError(
            error: e <| "error",
            message: e <| "message"
        )
    }
}
