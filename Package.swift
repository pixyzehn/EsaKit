import PackageDescription

let package = Package(
    name: "EsaKit"
    dependencies: [
        .Package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", "1.0.0-alpha.4"),
        .Package(url: "https://github.com/ikesyo/Himotoki.git", majorVersion: 3),
    ]
)

