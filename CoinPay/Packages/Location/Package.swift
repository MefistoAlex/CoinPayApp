// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Location",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "Location",
            targets: ["Location"]
        ),
    ],
    targets: [
        .target(
            name: "Location"
        ),

    ]
)
