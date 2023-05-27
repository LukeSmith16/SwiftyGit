// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyGit",
    products: [
        .library(
            name: "SwiftyGit",
            targets: ["SwiftyGit"]),
    ],
    targets: [
        .target(
            name: "SwiftyGit",
            dependencies: []),
        .testTarget(
            name: "SwiftyGitTests",
            dependencies: ["SwiftyGit"]),
    ]
)
