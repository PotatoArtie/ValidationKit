// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValidationKit",
    platforms: [
        .iOS(.v11), .macOS(.v10_13), .watchOS(.v4)
    ],
    products: [
        .library(
            name: "ValidationKit",
            targets: ["ValidationKit"]),
    ],
    targets: [
        .target(
            name: "ValidationKit",
            dependencies: []),
        .testTarget(
            name: "ValidationKitTests",
            dependencies: ["ValidationKit"]),
    ],
    swiftLanguageVersions: [.v5 ]
)
