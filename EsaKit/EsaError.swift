//
//  EsaError.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/22.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

/// An error from the esa.io API.
public struct EsaError: CustomStringConvertible, Error {
    /// The error message from the API.
    public let message: String

    public var description: String {
        return message
    }

    public init(message: String) {
        self.message = message
    }
}

extension EsaError: Hashable {
    public static func ==(lhs: EsaError, rhs: EsaError) -> Bool {
        return lhs.message == rhs.message
    }

    public var hashValue: Int {
        return message.hashValue
    }
}
