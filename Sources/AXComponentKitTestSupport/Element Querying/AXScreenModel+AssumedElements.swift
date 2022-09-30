import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Fetches an `XCUIElement` represented by the given `KeyPath`.
    ///
    /// This element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:timeout:file:line)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// let button = ExampleScreen.assumedElement(\.exampleButton)
    /// while !button.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement(
        _ path: KeyPath<Self, AXComponent>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement {
        let identifier = Self.component(path).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    // MARK: Dynamic Components

    /// Fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:value:timeout:)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = ExampleScreen.assumedElement(\.exampleCell, value: 20)
    /// while !cell.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    /// Fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:value:timeout:)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = ExampleScreen.assumedElement(\.exampleCell, value: 20)
    /// while !cell.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = component.resolve(value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    // MARK: Dynamic Components + StringProtocol

    /// Fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:value:timeout:)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = ExampleScreen.assumedElement(\.exampleCell, value: 20)
    /// while !cell.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: StringProtocol {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    // MARK: Dynamic Components + SignedInteger

    /// Fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:value:timeout:)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = ExampleScreen.assumedElement(\.exampleCell, value: 20)
    /// while !cell.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: SignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    // MARK: Dynamic Components + UnsignedInteger

    /// Fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:value:timeout:)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = ExampleScreen.assumedElement(\.exampleCell, value: 20)
    /// while !cell.exists {
    ///     XCUIApplication().scroll(byDeltaX: 0, deltaY: 100)
    /// }
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: UnsignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    /// Fetches an `XCUIElement` represented by the given `KeyPath`.
    ///
    /// Sometimes a protocol extension is provided that can only vend an XCUIElement
    /// because iOS does not provide a means to manage accessibility identifiers for the
    /// view in question. For example, a tab bar item, or a navigation bar element. This
    /// allows a uniform API to exist so that `XCTestCase` tests don't need to differentiate
    /// between `AXComponent`s and `XCUIElement`s when composing tests.
    ///
    /// This element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For example, one might use this
    /// to reference an offscreen element and scroll in a direction until that element
    /// comes into existence.
    ///
    /// For most use cases, prefer `element(_:timeout:file:line)` as it gives you
    /// assurances about the existence of the element before returning.
    ///
    /// ```
    /// let tab = ExampleScreen.assumedElement(\.tabItem)
    /// tab.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement(
        _ path: KeyPath<Self, XCUIElement>,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> XCUIElement {
        Self()[keyPath: path]
    }

    /// Allows for global `XCUIElement` querying based on unique identifiers
    ///
    /// - Parameters:
    ///   - identifier:
    ///         The unique identifier for the element in question
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         An `XCUIElement` that matches the given identifier
    internal static func assumedElement(
        matching identifier: String,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> XCUIElement {
        XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: identifier)
            .firstMatch
    }
}
