//
//  MembersTests.swift
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

class MembersTests: QuickSpec {
    override func spec() {
        describe("Members") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Members.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let member1 = MemberUser(
                    name: "Nagasawa Hiroki",
                    screenName: "hiroki_nagasawa",
                    icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!,
                    email: "pixyzehn@gmail.com",
                    postsCount: 222
                )

                let member2 = MemberUser(
                    name: "NAGASAWA HIROKI",
                    screenName: "pixyzehn",
                    icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!,
                    email: "pixyzehn+1@gmail.com",
                    postsCount: 111
                )

                let expected = Members(
                    members: [member1, member2],
                    page: 1,
                    prevPage: nil,
                    nextPage: 2,
                    maxPerPage: 100,
                    totalCount: 30
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.members()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, members):
                                expect(members).to(equal(expected))
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
