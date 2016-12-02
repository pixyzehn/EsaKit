//
//  TeamTests.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/12/01.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import ReactiveSwift
@testable import EsaKit

class TeamTests: QuickSpec {
    override func spec() {
        describe("A Team") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Team.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let expected = Team(
                    name: "esafeed",
                    privacy: "closed",
                    description: "",
                    icon: URL(string: "https://assets.esa.io/images/fallback/default-team-icon.png")!,
                    url: URL(string: "https://esafeed.esa.io/")!
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.team()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, team):
                                expect(team).to(equal(expected))
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
