//
//  CategoriesTests.swift
//  EsaKit
//
//  Created by pixyzehn on 2017/03/02.
//  Copyright © 2017 pixyzehn. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import ReactiveSwift
@testable import EsaKit

class CategoriesTests: QuickSpec {
    override func spec() {
        describe("Categories") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Categories.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let expected = Categories(
                    count: 3,
                    from: "/foo/bar/",
                    to: "/baz/"
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.batchMove(from: "/foo/bar/", to: "/baz/")
                        .startWithResult { result in
                            switch result {
                            case let .success(_, categories):
                                expect(categories).to(equal(expected))
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
