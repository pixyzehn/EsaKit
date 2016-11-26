# EsaKit [![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/pixyzehn/EsaKit/master/LICENSE.md)
A Swift framework for the esa.io API

```swift
let client = EsaClient(token: "...")
client.members(teamName: "esafeed")
    .startWithResult { result in
        switch result {
        case let .success(response):
            print("\(response)")
        case let .failure(error):
            print("\(error)")
        }
    }
```

EsaKit is build with [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift), [Curry](https://github.com/thoughtbot/Curry) and [Himotoki](https://github.com/ikesyo/Himotoki).
