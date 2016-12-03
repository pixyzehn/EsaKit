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
                    return fixture(filePath: stubPath, status: 200, headers: ["X-RateLimit-Limit": "75", "X-RateLimit-Remaining": "74"])
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let expected = Response(xRateLimitLimit: 75, XRateLimitRemaining: 74)

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
