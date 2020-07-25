// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "yap",
    defaultLocalization: "en",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "0.2.0")
    ],
    targets: [
        .target(
            name: "yap",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "yapTests",
            dependencies: ["yap"]),
    ]
)
