//
//  TeamsTests.swift
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

class TeamsTests: QuickSpec {
    override func spec() {
        describe("Teams") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Teams.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let team = Team(
                    name: "docs",
                    privacy: "open",
                    description: "esa.io official documents",
                    icon: URL(string: "https://img.esa.io/uploads/production/teams/105/icon/thumb_m_0537ab827c4b0c18b60af6cdd94f239c.png")!,
                    url: URL(string: "https://docs.esa.io/")!
                )

                let expected = Teams(
                    teams: [team],
                    page: 1,
                    prevPage: nil,
                    nextPage: 2,
                    maxPerPage: 100,
                    totalCount: 30
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.teams()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, teams):
                                expect(teams).to(equal(expected))
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
