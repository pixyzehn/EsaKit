//
//  CommentsTests.swift
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

class CommentsTests: QuickSpec {
    override func spec() {
        describe("Comments") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Comments.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let comment = Comment(
                    id: 1,
                    bodyMd: "This is a comment.",
                    bodyHTML: "<p>This is a comment.</p>",
                    createdAt: DateFormatter.iso8601.date(from: "2014-05-13T16:17:42+09:00")!,
                    updatedAt: DateFormatter.iso8601.date(from: "2014-05-18T23:02:29+09:00")!,
                    url: URL(string: "https://docs.esa.io/posts/13#comment-13")!,
                    createdBy: MinimumUser(name: "Nagasawa Hiroki", screenName: "hiroki_nagasawa", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    stargazersCount: 0,
                    star: false
                )

                let expected = Comments(
                    comments: [comment],
                    page: 1,
                    prevPage: nil,
                    nextPage: 2,
                    maxPerPage: 100,
                    totalCount: 30
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.comments(postNumber: 1)
                        .startWithResult { result in
                            switch result {
                            case let .success(_, comments):
                                expect(comments).to(equal(expected))
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
