//
//  UserTests.swift
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

class UserTests: QuickSpec {
    override func spec() {
        describe("A User") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("User.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let expected = User(
                    id: 1,
                    name: "Hiroki Nagasawa",
                    screenName: "hiroki_nagasawa",
                    createdAt: DateFormatter.iso8601.date(from: "2014-05-10T11:50:07+09:00")!,
                    updatedAt: DateFormatter.iso8601.date(from: "2016-04-17T12:35:16+09:00")!,
                    icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!,
                    email: "pixyzehn@gmail.com"
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.user()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, user):
                                expect(user).to(equal(expected))
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
