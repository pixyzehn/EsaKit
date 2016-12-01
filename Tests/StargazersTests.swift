//
//  StargazersTests.swift
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

class StargazersTests: QuickSpec {
    override func spec() {
        describe("Stargazers") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Stargazers.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let stargazer = Stargazer(
                    user: MinimumUser(name: "Nagasawa Hiroki", screenName: "hiroki_nagasawa", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    createdAt: DateFormatter.iso8601.date(from: "2016-05-05T11:40:54+09:00")!,
                    body: nil
                )

                let expected = Stargazers(
                    stargazers: [stargazer],
                    page: 1,
                    prevPage: nil,
                    nextPage: 2,
                    maxPerPage: 100,
                    totalCount: 30
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.stargazers(commentId: 8)
                        .startWithResult { result in
                            switch result {
                            case let .success(_, stargazers):
                                expect(stargazers).to(equal(expected))
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
