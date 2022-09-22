// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AXComponentKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AXComponentKit",
            targets: ["AXComponentKit"]
        ),
        .library(
            name: "AXComponentKitTestSupport",
            targets: ["AXComponentKitTestSupport"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AXComponentKit",
            dependencies: []
        ),
        .target(
            name: "AXComponentKitTestSupport",
            dependencies: [.targetItem(name: "AXComponentKit", condition: .none)]
        ),
    ]
)
