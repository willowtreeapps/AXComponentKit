# ``AXComponentKitTestSupport``

Writing your first UI test

## Overview

There is a good amount of work involved in setting up `AXComponentKit`, but the benefits of all of that work will be obvious once you start writing tests.  You should see quickly how the safety built into the framework for both querying elements and navigating throughout the app will make your tests easier both to write as well as to maintain than approaches that rely more heavily on team norms for best practices regarding safety.

### Your First Test

#### Setup Your Test Case

Test classes are typically constructed around the screen where the tests they contain start, however, more complex screens may be represented in more than one test class with the tests in each of those classes being defined by the functionality that they are testing. The following example references a simple screen in the test app, so one test class will suffice here.  When setting up a new test class, it is helpful to override the class' `setup` method, which is called at the beginning of each test with any code required to navigate to the screen being tested in the class.

```swift
@MainActor
final class SecondTabScreenTests: XCTestCase {
    override func setUp(completion: @escaping (Error?) -> Void) {
        setUp(completion: completion) {
            XCUIApplication().launch()
            try await FirstTabScreen.navigate(toTab: \.second)
        }
    }
```

In this example `setup` launches the app, and because this class is for tests of `SecondTabScreen`, the app will navigate immediately from the first tab to the second.  This code only has to be written once rather than at the beginning of each test. 

#### Writing a Test

`SecondTabScreen` contains a numbered list of rows in a `ScrollView`.  It is important to note that each of these rows has an identifier of type `AXDynamicComponent`, meaning that it has a unique identifier based on its row index. With this starting point, adding a test that taps the 4th item in a row looks like this.

```swift
final class SecondTabScreenTests: XCTestCase {
...
    func testCanTapSpecificRow() async throws {
        let row = try await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }
}
```

>Note: This query is marked with `try` and `await` to ensure safety by waiting for the the row to exist and failing the test before the tap if it does not.  

This test queries the 4th row and then taps it to navigate to a detail screen, but this logic assumes that the 4th item in the list is visible, which is not necessarily true if the view scrolls.  To reduce potential flakiness in this test that could occur as the screen grows and scales, we can make it safer by adding in the ability for the app to scroll if the element _might not be_ visible.  If the element is visible initially, it will be returned without scrolling. 

Typically, scrolling behavior in UI tests is tedious to write and can be flaky given the lack of clarity regarding the direction and duration of scrolling behavior, but `AXComponentKit` makes writing this code easy by providing methods for scrolling lists of `AXDynamicComponent`s that can be packaged into a navigation operation like so.

>Note: The following example shows a method with the same signature in two different extensions.  We _strongly_ recommend that you follow this model when implementing navigation operations to make your code as clean and clear at the call-site as possible.  For more information on how to implement navigation operations see "insert link here".

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
