# EsaKit [![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/pixyzehn/EsaKit/master/LICENSE.md)
A Swift framework for the [esa.io](https://esa.io/) API

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

EsaKit is build with [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift), [Himotoki](https://github.com/ikesyo/Himotoki) and [Sourcery](https://github.com/krzysztofzablocki/Sourcery).

## Requirements

EsaKit requires / supports the following environments:

- Swift 3.0 / Xcode 8.1
- OS X 10.10 or later
- iOS 9.0 or later

## Installation

#### [Carthage](https://github.com/Carthage/Carthage)

- Insert `github "pixyzehn/EsaKit"` to your Cartfile.
- Run `carthage update`.
- Link your app with `EsaKit.framework`, `Himotoki.framework`, `ReactiveSwift.framework` and `Result.framework` in `Carthage/Build`.

#### [CocoaPods](https://github.com/cocoapods/cocoapods)

- Insert `pod 'EsaKit'` to your Podfile.
- Run `pod install`.

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

- Add EsaKit as a dependency of your package in `Package.swift`. `.Package(url: "https://github.com/pixyzehn/EsaKit.git", majorVersion: 0, minor: 2)`

## Usage

Read the [docs](https://pixyzehn.com/EsaKit/). Generated with [jazzy](https://github.com/realm/jazzy).

```swift
// Initialization
let client = EsaClient(token: "your_token", teamName: "your_team_name")

// Team API
client.teams()
// #=> GET /v1/teams

client.team()
// #=> GET /v1/teams/[your_team_name]


// Stats API
client.stats()
// #=> GET /v1/teams/[your_team_name]/stats


// Member API
client.members()
// #=> GET /v1/teams/[your_team_name]/members


// Post API
client.posts()
// #=> GET /v1/teams/[your_team_name]/posts

client.posts(query: "in:help")
// #=> GET /v1/teams/[your_team_name]/posts?q=in%3Ahelp

client.post(postNumber: 1)
// #=> GET /v1/teams/[your_team_name]/posts/1

client.createPost(parameters: PostParameters(name: "title"))
// #=> POST /v1/teams/[your_team_name]/posts

client.updatePost(postNumber: 1, parameters: PostParameters(name: "other_title"))
// #=> PATCH /v1/teams/[your_team_name]/posts/1

client.deletePost(postNumber: 1)
// #=> DELETE /v1/teams/[your_team_name]/posts/1


// Comment API
client.comments(postNumber: 1)
// #=> GET /v1/teams/[your_team_name]/posts/1/comments

client.comment(commentId: 123)
// #=> GET /v1/teams/[your_team_name]/comments/123

client.createComment(postNumber, bodyMd: "baz")
// #=> POST /v1/teams/[your_team_name]/posts/1/comments

client.updateComment(commentId, bodyMd: "bazbaz")
// #=> PATCH /v1/teams/[your_team_name]/comments/123

client.delete_comment(commentId)
// #=> DELETE /v1/teams/[your_team_name]/comments/123


// Star API
client.stargazersInPost(postNumber: 1)
// #=> GET /v1/teams/[your_team_name]/posts/1/stargazers

client.addStarInPost(postNumber: 1)
// #=> POST /v1/teams/[your_team_name]/posts/1/star

client.removeStarInPost(postNumber: 1)
// #=> DELETE /v1/teams/[your_team_name]/posts/1/star

client.stargazersInComment(commentId: 123)
// #=> GET /v1/teams/[your_team_name]/comments/123/stargazers

client.addStarInComment(commentId: 123)
// #=> POST /v1/teams/[your_team_name]/comments/123/star

client.removeStarInComment(commentId: 123)
// #=> DELETE /v1/teams/[your_team_name]/comments/123/star


// Watch API
client.watchers(postNumber: 1)
// #=> GET /v1/teams/[your_team_name]/posts/1/watchers

client.addWatch(postNumber: 1)
// #=> POST /v1/teams/[your_team_name]/posts/1/watch

client.removeWatch(postNumber: 1)
// #=> DELETE /v1/teams/[your_team_name]/posts/1/watch


// Category API
client.batchMove(from: "/foo/bar/",to: "/baz/")
// #=> POST /v1/teams/[your_team_name]/categories/batch_move


// Authenticated User API
client.user()
// #=> GET /v1/user
```

## Contributing

1. Fork it ( https://github.com/pixyzehn/EsaKit )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request
