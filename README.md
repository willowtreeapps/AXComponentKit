# AXComponentKit

A modular, protocol-oriented UI testing framework for iOS that works in concert with XCTest. AXComponentKit provides typed screen models, composable navigation, and element querying abstractions that make UI tests more reliable, readable, and maintainable.

## Features

- **Screen models** — define screens as lightweight structs with typed component properties
- **Composable navigation** — chain navigators with compile-time safety across screen boundaries
- **Element querying** — type-safe element lookup with guaranteed-existence, assumed-existence, and first-match-by-prefix variants
- **Tab bar navigation** — protocol-based tab switching with `AXTabBarNavigable`
- **Scroll-to-element** — directional scroll helpers with timeout and failure reporting
- **Animation suppression** — automatic UIKit, Core Animation, and SwiftUI animation disabling for test runs
- **`@AXScreen` macro** — optional syntactic sugar that auto-generates `screenIdentifier` from type names
- **Swift 6 ready** — full strict concurrency compliance

## Installation

AXComponentKit is distributed as a Swift Package with three products:

```swift
dependencies: [
    .package(url: "https://github.com/willowtreeapps/AXComponentKit", from: "2.0.0"),
]
```

| Product | Purpose | Link to |
|---------|---------|---------|
| `AXComponentKit` | Screen models, components, view modifiers | App target |
| `AXComponentKitTestSupport` | Navigators, element queries, test helpers | UI test target |
| `AXComponentKitMacroSupport` | `@AXScreen` macro (optional, adds swift-syntax) | App target |

## Quick Start

### 1. Define a screen model

```swift
import AXComponentKit
import AXComponentKitMacroSupport  // optional, for @AXScreen

@AXScreen
struct LoginScreen {
    let usernameField: AXComponent = "login-username-field"
    let passwordField: AXComponent = "login-password-field"
    let submitButton: AXComponent = "login-submit-button"
}
```

Without the macro:

```swift
struct LoginScreen: AXScreen {
    static let screenIdentifier = "login-screen"
    let usernameField: AXComponent = "login-username-field"
    let passwordField: AXComponent = "login-password-field"
    let submitButton: AXComponent = "login-submit-button"
}
```

### 2. Apply modifiers in your views

```swift
struct LoginView: View {
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .automationComponent(\LoginScreen.usernameField)
            SecureField("Password", text: $password)
                .automationComponent(\LoginScreen.passwordField)
            Button("Sign In") { login() }
                .automationComponent(\LoginScreen.submitButton)
        }
        .automationScreen(LoginScreen.self)
    }
}
```

### 3. Write navigator extensions

```swift
import AXComponentKitTestSupport

extension AXScreenNavigator where Source == LoginScreen {
    @discardableResult
    func login(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<HomeScreen> {
        try await navigate(file: file, line: line) { screen in
            try await screen.tap(\.submitButton)
        }
    }
}
```

### 4. Write tests

```swift
@MainActor
final class LoginTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
    }

    func testCanLogin() async throws {
        try await LoginScreen.exists()
        try await LoginScreen.navigator.login()
        try await HomeScreen.exists()
    }
}
```

## Animation Suppression

AXComponentKit automatically suppresses animations during test runs to improve speed and reliability.

**App side** — add one modifier at your root view:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .automationOptimized()
        }
    }
}
```

For UIKit apps, call from your AppDelegate:

```swift
AXAutomation.suppressAnimationsIfNeeded()
```

**Test side** — use `automationLaunch()` instead of `launch()`:

```swift
override func setUp() async throws {
    XCUIApplication.automationLaunch()
}
```

This injects a launch argument that the app-side modifier detects. In production (without the argument), both APIs are no-ops with zero runtime cost.

## Dynamic Components

For elements identified at runtime (list rows, category cards, etc.), use `AXDynamicComponent`:

```swift
@AXScreen
struct CatalogScreen {
    let categoryCard: AXDynamicComponent<String> = "catalog-category"
    let itemRow: AXDynamicComponent<Int> = "catalog-item"
}
```

Query them with a value:

```swift
try await CatalogScreen.element(\.categoryCard, value: "electronics")
try await CatalogScreen.element(\.itemRow, value: 42)
```

When the value may be nil (e.g. during loading states), pass an optional to suppress the identifier entirely:

```swift
Text(item.name)
    .automationComponent(\CatalogScreen.categoryCard, value: item.slug)
```

If you need to distinguish elements that share a component definition, supply a custom prefix:

```swift
Text(item.name)
    .automationComponent(\CatalogScreen.categoryCard, value: item.slug, prefix: "featured")
// identifier: "featured-catalog-category_electronics"
```

When the exact dynamic value isn't known at test time, query for the first matching element by prefix:

```swift
let card = try await CatalogScreen.firstElement(anyOf: \.categoryCard)
card.tap()

// Or as a single call:
try await CatalogScreen.tapFirst(anyOf: \.categoryCard)
```

Custom types can conform to `AXIdentifierConvertible` (or its refinement `AXDynamicValue`) for use as dynamic values.

## Capability Protocols

Share components across screens using protocol composition:

```swift
protocol DismissibleScreen: AXScreen {
    var dismissButton: AXComponent { get }
}

extension AXScreenNavigator where Source: DismissibleScreen {
    func dismiss() async throws {
        try await Source.tap(\.dismissButton)
    }
}
```

## Documentation

- [AXComponentKit](https://willowtreeapps.github.io/AXComponentKit/framework/documentation/axcomponentkit/) — app-side API reference
- [AXComponentKitTestSupport](https://willowtreeapps.github.io/AXComponentKit/testing/documentation/axcomponentkittestsupport/) — test-side API reference

## Requirements

- iOS 16+ / macOS 13+
- Swift 6.0+
- Xcode 16+

## License

See [LICENSE](LICENSE) for details.
