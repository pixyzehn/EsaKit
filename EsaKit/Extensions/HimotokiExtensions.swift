//
//  HimotokiExtensions.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/11/26.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Foundation
import Himotoki
import Result

internal func decode<T: Decodable>(_ object: Any) -> Result<T, DecodeError> {
    do {
        let decoded = try T.decodeValue(object)
        return .success(decoded)
    } catch let error as DecodeError {
        return .failure(DecodeError.custom("\(error)"))
    } catch {
        return .failure(DecodeError.custom("This is not Decode error."))
    }
}
