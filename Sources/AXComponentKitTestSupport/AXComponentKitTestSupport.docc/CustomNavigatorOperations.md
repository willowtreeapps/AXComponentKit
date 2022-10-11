# Custom Navigator Operations

Making your own composable operations

The body and parameters of your navigation function can be practically anything needed to help make your test execution steps as succinct and readable as possible. Let's look again at the example from our sample project that navigates to an arbitrary item on the second tab. You'll see that it's actually pretty lean:

```swift
extension AXScreenNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await performNavigation(file: file, line: line) { screen in
            try await scroll(to: \.rowItem, value: ordinal, in: \.table, file: file, line: line)
            let rowItem = try await screen.element(\.rowItem, value: ordinal, file: file, line: line)
            rowItem.tap()
        }
    }
}
```
Since navigation operations are atomic, we are assured that we're on the source screen. We can focus on any and all factors that might affect the success of this operation, and ensure that it is equipped to succeed. In this example, there is no limit on the value that can be passed for `ordinal`, so we must first guarantee we can scroll down to find it in the event that the element is offscreen.

These kinds of guarantees can be difficult. What if the screen is somehow scrolled down already when this executes? As written, we don't have a way to deal with that. Most of the time we simply don't have enough information to know which direction we should scroll based on what is currently visible. Perhaps a future version of the framework will allow us to be more intelligent about this, but for now we can only move in a prescribed direction.

### Static Variants

The actual version of our example function has an extra method with the same signature in a different extension.  We _strongly_ recommend that you follow this pattern when implementing navigation operations to make your code as clean and clear at the call-site as possible.  This additional variant is an extension on the source screen model's type, adding a static function of the same name:

```swift
extension SecondTabScreen {
    @discardableResult
    static func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await Navigator().navigate(toItem: ordinal, file: file, line: line)
    }
}

extension AXScreenNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await performNavigation(file: file, line: line) { screen in
            try await scroll(to: \.rowItem, value: ordinal, in: \.table, file: file, line: line)
            let rowItem = try await screen.element(\.rowItem, value: ordinal, file: file, line: line)
            rowItem.tap()
        }
    }
}
```

Here is the before and after of having this extra extension:

```swift
    SecondTabScreen.Navigator().navigate(toItem: 3) // Before 
    SecondTabScreen.navigate(toItem: 3)             // After
```


### Using The Navigator Extension

With a navigation operation that takes care of the scrolling behavior in place, we can call `navigate(toItem)` on `SecondTabScreen` like so.

```swift
func testCanNavigateToDetailScreen() async throws {
    try await SecondTabScreen.navigate(toItem: 3)
}
```

A test that _must_ scroll to find the specified element would be essentially identical.

```swift
func testCanScrollDownAndNavigate() async throws {
    try await SecondTabScreen.navigate(toItem: 80)
}
```
