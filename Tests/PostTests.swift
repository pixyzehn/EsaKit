//
//  PostTests.swift
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

class PostTests: QuickSpec {
    override func spec() {
        describe("A Post") {
            beforeEach {
                stub(condition: isHost("api.esa.io")) { _ in
                    let stubPath = OHPathForFile("Post.json", type(of: self))!
                    return fixture(filePath: stubPath, status: 200, headers: nil)
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("when a response is expected response") {
                let expected = Post(
                    number: 5,
                    name: "hi!",
                    fullName: "daily/2015/05/10/hi! #api #dev",
                    wip: false,
                    bodyMd: "# Getting Started\n",
                    bodyHTML: "<h1 id=\"1-0-0\" name=\"1-0-0\">\n<a class=\"anchor\" href=\"#1-0-0\"><i class=\"fa fa-link\"></i><span class=\"hidden\" data-text=\"Getting Started\"> &gt; Getting Started</span></a>Getting Started</h1>\n",
                    createdAt: DateFormatter.iso8601.date(from: "2015-05-09T12:12:37+09:00")!,
                    updatedAt: DateFormatter.iso8601.date(from: "2015-05-09T12:19:48+09:00")!,
                    message: "Add Getting Started section",
                    url: URL(string: "https://docs.esa.io/posts/5")!,
                    tags: ["api", "dev"],
                    category: "日報/2015/05/10",
                    revisionNumber: 2,
                    createdBy: MinimumUser(name: "Nagasawa Hiroki", screenName: "hiroki_nagasawa", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    updatedBy: MinimumUser(name: "Nagasawa Hiroki", screenName: "hiroki_nagasawa", icon: URL(string: "https://img.esa.io/uploads/production/users/7823/icon/thumb_m_515f07fb32acee87474905b96cdc3c15.jpg")!),
                    kind: "flow",
                    commentsCount: 0,
                    tasksCount: 0,
                    doneTasksCount: 0,
                    stargazersCount: 0,
                    watchersCount: 1,
                    star: false,
                    watch: false
                )

                waitUntil { done in
                    let client = EsaClient(token: "token", teamName: "team")
                    client.post(postNumber: 5)
                        .startWithResult { result in
                            switch result {
                            case let .success(_, post):
                                expect(post).to(equal(expected))
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
