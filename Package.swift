// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "yap",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "0.0.1"),

    ],
    targets: [
        .target(
            name: "yap",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"),
                ]),
        .testTarget(
            name: "yapTests",
            dependencies: ["yap"]),
    ]
)
