# EsaKit [![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/pixyzehn/EsaKit/master/LICENSE.md)
A Swift framework for the esa.io API

```swift
let client = EsaClient(token: "...", teamName: "esafeed")
client.members()
    .startWithResult { result in
        switch result {
        case let .success(response):
            print("\(response)")
        case let .failure(error):
            print("\(error)")
        }
    }
```

EsaKit is build with [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) and [Himotoki](https://github.com/ikesyo/Himotoki).

## Contributing

1. Fork it ( https://github.com/pixyzehn/EsaKit )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request
