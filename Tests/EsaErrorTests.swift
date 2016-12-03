//
//  EsaErrorTests.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/12/03.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import ReactiveSwift
@testable import EsaKit

class EsaErrorTests: QuickSpec {
    override func spec() {
        describe("An EsaError") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Error.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 500, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let expected = EsaError(
                    error: "not_found",
                    message: "Not found"
                )

                let expectedResponse = Response(xRateLimitLimit: 0, XRateLimitRemaining: 0)

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.comment(commentId: 10)
                        .startWithResult { result in
                            switch result {
                            case .success(_, _):
                                fatalError()
                            case let .failure(error):
                                if case let EsaClient.Error.apiError(code, response, error) = error {
                                    expect(code).to(equal(500))
                                    expect(response).to(equal(expectedResponse))
                                    expect(error).to(equal(expected))
                                } else {
                                    fatalError()
                                }
                            }
                            done()
                    }
                }
            }
        }
    }
}
