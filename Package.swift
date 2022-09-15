// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Logger",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
    ],
    products: [
        .library(
            name: "Logger",
            targets: ["Logger"]
        ),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Logger",
            dependencies: []
        ),
    ]
)
