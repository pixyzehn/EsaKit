# EsaKit [![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/pixyzehn/EsaKit/master/LICENSE.md)
A Swift framework for the esa.io API

```swift
let client = EsaClient(token: "your_token", teamName: "your_team_name")
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
```

EsaKit is build with [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) and [Himotoki](https://github.com/ikesyo/Himotoki).

## Contributing

1. Fork it ( https://github.com/pixyzehn/EsaKit )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request
