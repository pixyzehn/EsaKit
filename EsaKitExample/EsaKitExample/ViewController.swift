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

        let client = EsaClient(token: "your_token", teamName: "your_team_name")
        client.posts(query: "help")
            .startWithResult { result in
                switch result {
                case let .success(response):
                    print("\(response)")
                case let .failure(error):
                    print("An error occured: \(error)")
                }
        }
    }
}
