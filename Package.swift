import PackageDescription

let package = Package(
    name: "EsaKit",
    dependencies: [
        .Package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", majorVersion: 1),
    ]
)

