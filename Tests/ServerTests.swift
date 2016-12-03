//
//  ServerTests.swift
//  EsaKit
//
//  Created by pixyzehn on 2016/12/03.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift
@testable import EsaKit

class SertverTests: QuickSpec {
    override func spec() {
        describe("A server") {
            it("When URL and Endpoint are correct") {
                let server = Server()

                let expectedURLString = "https://esa.io"
                let expectedURL = URL(string: expectedURLString)!
                let expectedEndpoint = "https://api.esa.io"

                expect(server.url).to(equal(expectedURL))
                expect(server.endpoint).to(equal(expectedEndpoint))
                expect(server.description).to(equal(expectedURLString))
            }
        }
    }
}
