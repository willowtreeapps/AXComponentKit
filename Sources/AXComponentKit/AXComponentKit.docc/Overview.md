# ``AXComponentKit``

Modular UI testing framework abstraction that works in concert with XCTest

## Overview

AXComponentKit provides a type-safe, composable layer on top of XCTest UI automation. Rather than littering tests with raw string-based accessibility identifier lookups, AXComponentKit lets you declare your screens and their interactive components as Swift types. The test runner then uses those types to locate elements, verify screen transitions, and surface actionable errors when expectations aren't met.

The framework is split into two targets:

- **AXComponentKit** — ships with your app target. Contains the `@AXScreen` macro, the `AXScreen` protocol, component types (`AXComponent`, `AXDynamicComponent`, `AXScrollView`), and view modifiers that wire components into the accessibility tree.
- **AXComponentKitTestSupport** — added to your UI test target only. Contains `AXScreenNavigator`, element-querying helpers, and the composable navigation primitives.

#### Getting Started

- <doc:Philosophy>
- <doc:ScreenModels>
- <doc:IntegratingWithViews>

- [Writing tests](https://jubilant-disco-651a42c5.pages.github.io/testing/documentation/axcomponentkittestsupport/)

#### Adding To Your Project

Add AXComponentKit via Swift Package Manager. In Xcode, choose **File › Add Package Dependencies…** and enter the repository URL. Then:

1. Add **AXComponentKit** to your app target.
2. Add **AXComponentKitTestSupport** to your UI test target only — never to the app target, as it links against XCTest.

Or, in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/willowtreeapps/AXComponentKit.git", from: "2.0.0"),
],
targets: [
    .target(
        name: "MyApp",
        dependencies: ["AXComponentKit"]
    ),
    .testTarget(
        name: "MyAppUITests",
        dependencies: ["AXComponentKitTestSupport"]
    ),
]
```

