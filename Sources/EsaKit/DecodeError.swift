//
//  DecodeError.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/04/20.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Foundation

public enum DecodeError: Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
    case custom(String)
}
