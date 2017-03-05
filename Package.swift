import PackageDescription

let package = Package(
    name: "EsaKit",
    dependencies: [
        .Package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", majorVersion: 1),
        .Package(url: "https://github.com/ikesyo/Himotoki.git", majorVersion: 3),
    ]
)

