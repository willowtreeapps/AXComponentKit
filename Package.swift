// swift-tools-version: 5.7

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
            dependencies: [],
            exclude: ["AXComponentKit/AXComponentKit.docc"]
        ),
        .target(
            name: "AXComponentKitTestSupport",
            dependencies: [.targetItem(name: "AXComponentKit", condition: .none)],
            exclude: ["AXComponentKit/AXComponentKitTestSupport.docc"]
        ),
    ]
)
