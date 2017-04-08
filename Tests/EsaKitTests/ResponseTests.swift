//
//  ResponseTests.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/12/02.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import ReactiveSwift
@testable import EsaKit

class ResponseTests: QuickSpec {
    override func spec() {
        describe("A Response") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Post.json", type(of: self))!
                    let headers = ["X-RateLimit-Limit": "75", "X-RateLimit-Remaining": "74", "X-RateLimit-Reset": "1491543000"]
                    return fixture(filePath: stubPath, status: 200, headers: headers)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let expected = Response(
                    xRateLimitLimit: 75,
                    xRateLimitRemaining: 74,
                    xRateLimitReset: 1491543000
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.post(postNumber: 5)
                        .startWithResult { result in
                            switch result {
                            case let .success(response, _):
                                expect(response).to(equal(expected))
                            case let .failure(error):
                                fatalError("Error: \(error)")
                            }
                            done()
                    }
                }
            }
        }
    }
}
