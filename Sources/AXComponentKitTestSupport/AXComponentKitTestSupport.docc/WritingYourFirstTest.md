# ``AXComponentKitTestSupport``

Writing your first UI test

## Overview

There is a good amount of work involved in setting up `AXComponentKit`, but the benefits of all of that work will be obvious once you start writing tests.  You should see quickly how the safety built into the framework for both querying elements and navigating throughout the app will make your tests easier both to write as well as to maintain than approaches that rely more heavily on team norms for best practices regarding safety.

### Create a Test Case

Test classes are typically constructed around the screen where the tests they contain start, however, more complex screens may be represented in more than one test class with the tests in each of those classes being defined by the functionality that they are testing. The following example references a simple screen in the test app, so one test class will suffice here.  When setting up a new test class, it is helpful to override the async `setUp` method, which is called at the beginning of each test with any code required to navigate to the screen being tested in the class.

```swift
@MainActor
final class SecondTabScreenTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
        try await FirstTabScreen.navigator.navigate(toTab: \.second)
    }
```

In this example `setUp` launches the app using `XCUIApplication.automationLaunch()` (which sets the AXComponentKit runner flag and calls `launch()`), and because this class is for tests of `SecondTabScreen`, the app will navigate immediately from the first tab to the second. This code only has to be written once rather than at the beginning of each test.

#### Writing a Test

`SecondTabScreen` contains a numbered list of rows in a `ScrollView`. It is important to note that each of these rows has an identifier of type `AXDynamicComponent`, meaning that it has a unique identifier based on its row index. With this starting point, adding a test that taps the 4th item in a row looks like this.

```swift
final class SecondTabScreenTests: XCTestCase {
...
    func testCanTapSpecificRow() async throws {
        let row = try await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }
}
```

> Tip: `AXScreenModel` also provides a `tap()` convenience method that combines element querying and tapping in a single call:
> ```swift
> try await SecondTabScreen.tap(\.rowItem, value: 3)
> ```

>Note: This query is marked with `try` and `await` to ensure safety by waiting for the the row to exist and failing the test before the tap if it does not.  

#### Querying When the Value Is Unknown

Sometimes the exact dynamic value isn't known at test time — for example, tapping the first item in a list of server-returned data. Use `firstElement(anyOf:)` to find the first element whose identifier begins with the component's prefix, regardless of the value suffix:

```swift
func testCanTapFirstRow() async throws {
    let row = try await SecondTabScreen.firstElement(anyOf: \.rowItem)
    row.tap()
}
```

Or combine the query and tap into a single call:

```swift
func testCanTapFirstRow() async throws {
    try await SecondTabScreen.tapFirst(anyOf: \.rowItem)
}
```

Both methods wait for the element to exist before interacting with it, following the same safety guarantees as the value-based queries.

#### Scrolling to Off-Screen Elements

This test queries the 4th row and then taps it to navigate to a detail screen, but this logic assumes that the 4th item in the list is visible, which is not necessarily true if the view scrolls.  To reduce potential flakiness in this test that could occur as the screen grows and scales, we can make it safer by adding in the ability for the app to scroll if the element _might not be_ visible.  If the element is visible initially, it will be returned without scrolling. 

To address this, see how we use this example to create a custom navigator extension in <doc:CustomNavigatorOperations>
