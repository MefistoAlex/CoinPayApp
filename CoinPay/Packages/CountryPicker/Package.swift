// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CountryPicker",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CountryPicker",
            targets: ["CountryPicker"]
        ),
    ],
    dependencies: [
        .package(path: "../Location")
    ],
    targets: [
       .target(
            name: "CountryPicker",
            dependencies: [
                .product(name: "Location", package: "Location")
            ]
        ),

    ]
)
