//
//  Server.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/19.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

public enum Server: CustomStringConvertible {
    /// An esa.io server.
    case dotIo

    /// The URL of the server.
    public var url: URL {
        switch self {
        case .dotIo:
            return URL(string: "https://esa.io")!
        }
    }

    internal var endpoint: String {
        switch self {
        case .dotIo:
            return "https://api.esa.io"
        }
    }

    public var description: String {
        return "\(url)"
    }
}
