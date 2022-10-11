# Navigators
How to make tests move from one place to another

``AXScreenNavigator`` is the foundational building block for handling navigation in a UI automation test. The navigator itself is generic and takes an `AXScreenModel`, which acts as its source. Declaring a new navigator for the first tab screen in our sample app looks like this:
```swift
let navigator = AXScreenNavigator<FirstTabScreen>()
```

We usually read this as "A navigator starting at FirstTabScreen." Alternatively, `AXComponentKit` includes a typealias on `AXScreen` that makes it possible to get the navigator for a given screen like this:
```swift
let navigator = FirstTabScreen.Navigator() // AXScreenNavigator<FirstTabScreen>
```
Most places create navigator instances in this way because it's more concise, but both are valid constructions that mean the same thing.

A navigator allows the test runner to begin at the source screen and perform some operation to move to a destination screen. Here's an example from our sample app that starts at the first tab's screen and navigates to the second tab:
```swift
try await FirstTabScreen.navigate(toTab: \.second)
```

Every operation that a navigator can perform returns a new navigator instance for the destination screen. This is where navigator composition becomes really powerful, as seen here, where we move to the second tab and then immediately navigate to the third item in the list:

```swift
try await FirstTabScreen.navigate(toTab: \.second) // AXScreenNavigator<SecondTabScreen>
                        .navigate(toItem: 3)       // AXScreenNavigator<DetailScreen>
```

> Note: In some places we refer to this as "chaining," as we're chaining together consecutive operations into one large navigation task.

### Adding New Navigator Operations

Adding new operations to ``AXScreenNavigator`` is similar to how we add capabilities to `AXScreenModel`s. Protocol extensions allow us to add operations to navigators that have a specific source screen. This means that operations we define for `SecondTabScreen` cannot show up on a navigator that starts on `FirstTabScreen`. Here's an example of how a new navigator extension is declared:

```swift
// Swift < 5.7
extension AXScreenModel where Source == SecondTabScreen {
    ...
}

// Swift 5.7+
extension AXScreenModel<SecondTabScreen> {
    ...
}
```
> Note: For the sake of compatability and better compile times, we use pre-5.7 Swift syntax.

> Warning: When adding new `AXScreenNavigator` extensions, be sure they are being added to your UI testing target ONLY. `AXScreenNavigator` relies on the `XCTest` framework, which is not available for standard application code.

##### Fundamentals

Adding a new operation inside these extensions involves a decent amount of boilerplate that can be a lot to digest. Here's a quick primer on what all those pieces are, taken directly from the function we used above (but omitting the good stuff for now):

```swift
extension AXScreenNavigator where Source == SecondTabScreen {
    @discardableResult                                                   // 1
    func navigate(
        toItem index: Int,                                               // 2
        file: StaticString = #file,                                      // 3
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {                  // 4, 5
        try await performNavigation(file: file, line: line) { _ in  // 6
            // TODO: Interact with the app
        }
    }
}
```
1. The `@discardableResult` allows us to invoke a chain of navigators without Swift forcing us to do something with the last navigator in the chain. Without it, we would have to write something like `_ = SecondTabScreen.Navigator().performNavigation(toItem: 3)`.
    Instead, `@discardableResult` lets us ignore the fact that the function returned anything at all: `SecondTabScreen.Navigator().performNavigation(toItem: 3)`
1. The element we're going to navigate to is an `AXDynamicComponent<Int>`, so we need to know the value in order to locate the correct row and tap on it. We'll ignore this for now since we're going to focus on the actual test interactions down below.
1. AXComponentKit has `file` and `line` parameters tacked onto nearly every function. We recommend you pay it forward and keep these in your functions as well. When an `XCTFail` or assertion occurs down deeper in the framework, these ensure that the correct file and line number are reported as the source of failure. 
    In practical terms, this means that an assertion failure down deep in `AXComponentKit` will report as a failure all the way up at the call site in your `XCTestCase`. 
        _insert picure_
1. Practically all navigator operations are `async` in nature because they wait for the source/destination screens to exist, and for elements to become available. Since those tasks are asynchronous, all of our navigation operations that use then must also be asynchronous. In practice, this makes for cleaner code in test cases because it becomes much clearer _which_ operations are going to involve the passage of time.

    > Note: If you are new to Swift or structured concurrency, this is what necessitates the `await` when calling async functions. The Swift [documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) on concurrency is a great resource for more info.
1. `throws` is similar to the `async` keyword in that nature of the functions our navigation operations are dependent on, most of those functions are also capable of throwing an error when a failure occurs. This is important because test execution won't [necessarily](https://developer.apple.com/documentation/xctest/xctestcase/1496260-continueafterfailure) stop executing simply because an assertion fails at some point in your test. By throwing when an error occurs, we have an escape hatch to abort when an expected condition is not satisfied and guarantee that the test case will not continue.
1. `performNavigation(...)` should be present in all navigator operations because it handles the assertions around source/destination screen existence. The function returns the destination navigator when that screen appears, and Swift's implicit return values + type inference make calling the function more succinct than it would be if we wrote out everything fully:
```swift
extension AXScreenNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigate(
        toItem index: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        return try await performNavigation(to: DetailScreen.self, file: file, line: line) { _ in
            // TODO: Interact with the app
        }
    }
}
```


##### Xcode Code Snippet

Once you understand the fundamentals of a navigator operation, you can start building your own extensions. If you find yourself making these often (you should!), then we encourage [adding this](https://sarunw.com/posts/how-to-create-code-snippets-in-xcode/) as an Xcode snippet:
```swift
extension AXScreenNavigator where Source == <#Source#> {
    @discardableResult
    func navigate(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<<#Destination#>> {
        try await performNavigation(file: file, line: line) { screen in
            <#Body#>
        }
    }
}
```
It will help make the boilerplate a breeze!


##### Functionality

The body and parameters of your navigation function can be practically anything needed to help make your test execution steps as succinct and atomic as possible. Let's look at the full example we started with from our example project. You'll see that it's actually pretty lean:

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
Since navigation operations are atomic, we are assured that we're on the source screen. We can focus on any and all factors that might affect the success of this operation, and ensure that it's equipped to succeed. In this example, there is no limit on the value that can be passed for `ordinal`, so we must first guarantee we can scroll down to find it in the event that the element is offscreen.

These kinds of guarantees can be difficult. What if the screen is somehow scrolled down already when this executes? As written, we don't have a way to deal with that. Most of the time we simply don't have enough information to know which direction we should scroll based on what is currently visible. Perhaps a future version of the framework will allow us to be more intelligent about this, but for now we can only move in a prescribed direction.
