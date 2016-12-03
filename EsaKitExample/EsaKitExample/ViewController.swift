//
//  ViewController.swift
//  EsaKitExample
//
//  Created by pixyzehn on 2016/11/24.
//  Copyright © 2016 pixyzehn. All rights reserved.
//

import UIKit
import EsaKit
import ReactiveSwift
import Result

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = EsaClient(token: "your_token", teamName: "your_team")
        client.members()
            .startWithResult { result in
                switch result {
                case let .success(response, members):
                    print("\(response)") // => Response(xRateLimitLimit: 75, XRateLimitRemaining: 71)
                    print("\(members)")  // => Memberss(members: [EsaKit.MemberUser(name:...
                case let .failure(error):
                    print("An error occured: \(error)")
                }
        }

        client.teamName = "other_your_team_name"
        client.posts()
            .startWithResult { result in
                switch result {
                case let .success(response, posts):
                    print("\(response)") // => Response(xRateLimitLimit: 75, XRateLimitRemaining: 70)
                    print("\(posts)")    // => Posts(posts: [EsaKit.Post(number: 11, name:...
                case let .failure(error):
                    print("An error occured: \(error)")
                }
        }
    }
}
