//
//  PostsTests.swift
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

class PostsTests: QuickSpec {
    override func spec() {
        describe("Posts") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Posts.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is an expected response") {
                let post = Post(
                    number: 1,
                    name: "hi!",
                    fullName: "daily/2015/05/09/hi! #api #dev",
                    wip: true,
                    bodyMd: "# Getting Started",
                    bodyHTML: "<h1 id=\"1-0-0\" name=\"1-0-0\">\n<a class=\"anchor\" href=\"#1-0-0\"><i class=\"fa fa-link\"></i><span class=\"hidden\" data-text=\"Getting Started\"> &gt; Getting Started</span></a>Getting Started</h1>\n",
                    createdAt: DateFormatter.iso8601.date(from: "2015-05-09T11:54:50+09:00")!,
                    updatedAt: DateFormatter.iso8601.date(from: "2015-05-09T11:54:51+09:00")!,
                    message: "Add Getting Started section",
                    url: URL(string: "https://docs.esa.io/posts/1")!,
                    tags: ["api", "dev"],
                    category: "daily/2015/05/09",
                    revisionNumber: 1,
                    createdBy: MinimumUser(name: "Nagasawa Hiroki", screenName: "hiroki_nagasawa", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    updatedBy: MinimumUser(name: "NAGASAWA HIROKI", screenName: "pixyzehn", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    kind: "flow",
                    commentsCount: 0,
                    tasksCount: 0,
                    doneTasksCount: 0,
                    stargazersCount: 0,
                    watchersCount: 0,
                    star: false,
                    watch: false
                )

                let expected = Posts(
                    posts: [post],
                    page: 1,
                    prevPage: nil,
                    nextPage: 2,
                    perPage: 20,
                    maxPerPage: 100,
                    totalCount: 30
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.posts()
                        .startWithResult { result in
                            switch result {
                            case let .success(_, posts):
                                expect(posts).to(equal(expected))
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
