// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "AXComponentKit",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "AXComponentKit",
            targets: ["AXComponentKit"]
        ),
        .library(
            name: "AXComponentKitTestSupport",
            targets: ["AXComponentKitTestSupport"]
        ),
        .library(
            name: "AXComponentKitMacroSupport",
            targets: ["AXComponentKitMacroSupport"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0"),
    ],
    targets: [
        .target(
            name: "AXComponentKit",
            dependencies: []
        ),
        .target(
            name: "AXComponentKitTestSupport",
            dependencies: [.targetItem(name: "AXComponentKit", condition: .none)]
        ),
        .macro(
            name: "AXComponentKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "AXComponentKitMacroSupport",
            dependencies: [
                "AXComponentKit",
                "AXComponentKitMacros",
            ]
        ),
        .testTarget(
            name: "AXComponentKitMacrosTests",
            dependencies: [
                "AXComponentKitMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
