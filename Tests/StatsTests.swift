//
//  StatsTests.swift
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

class StatsTests: QuickSpec {
    override func spec() {
        describe("A Stats") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Stats.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let expected = Stats(
                    members: 20,
                    posts: 1959,
                    postsWip: 59,
                    postsShipped: 1900,
                    comments: 2695,
                    stars: 3115,
                    dailyActiveUsers: 8,
                    weeklyActiveUsers: 14,
                    monthlyActiveUsers: 15
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.stats()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, stats):
                                expect(stats).to(equal(expected))
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
