//
//  Decodable.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/04/20.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Foundation
import Result

public protocol Decodable {
    static func decode(json: Any) throws -> Self
}

internal func decode<T: Decodable>(_ object: Any) -> Result<T, DecodeError> {
    do {
        let decoded = try T.decode(json: object)
        return .success(decoded)
    } catch {
        return .failure(DecodeError.custom("\(error) in \(object)"))
    }
}
