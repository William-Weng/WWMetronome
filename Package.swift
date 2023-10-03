// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWMetronome",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWMetronome", targets: ["WWMetronome"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "WWMetronome", dependencies: []),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
