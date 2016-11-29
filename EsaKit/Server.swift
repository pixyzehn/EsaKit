//
//  Server.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/19.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation

/// An esa.io server.
public struct Server: CustomStringConvertible {
    public var url: URL {
        return URL(string: "https://esa.io")!
    }

    internal var endpoint: String {
        return "https://api.esa.io"
    }

    public var description: String {
        return "\(url)"
    }
}
