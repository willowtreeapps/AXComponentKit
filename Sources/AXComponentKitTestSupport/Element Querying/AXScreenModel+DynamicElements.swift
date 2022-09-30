import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    // MARK: AXDynamicValue

    /// Asynchronously fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value. The returned element is guaranteed to exist
    /// when this function returns and can be safely interacted with.
    ///
    /// This is the preferred way to interact with UI elements, as not waiting for them to exist
    /// is a common source of flaky test failures due to laggy interactions in slow execution
    /// environments, such as a virtual instance in a CI pipeline.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = try await ExampleScreen.element(\.exampleCell, value: 20)
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         A resolved `XCUIElement` whose existence has been ensured
    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: StringProtocol

    /// Asynchronously fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value. The returned element is guaranteed to exist
    /// when this function returns and can be safely interacted with.
    ///
    /// This is the preferred way to interact with UI elements, as not waiting for them to exist
    /// is a common source of flaky test failures due to laggy interactions in slow execution
    /// environments, such as a virtual instance in a CI pipeline.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = try await ExampleScreen.element(\.exampleCell, value: 20)
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         A resolved `XCUIElement` whose existence has been ensured
    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: StringProtocol {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: SignedInteger

    /// Asynchronously fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value. The returned element is guaranteed to exist
    /// when this function returns and can be safely interacted with.
    ///
    /// This is the preferred way to interact with UI elements, as not waiting for them to exist
    /// is a common source of flaky test failures due to laggy interactions in slow execution
    /// environments, such as a virtual instance in a CI pipeline.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = try await ExampleScreen.element(\.exampleCell, value: 20)
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         A resolved `XCUIElement` whose existence has been ensured
    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: SignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: UnsignedInteger

    /// Asynchronously fetches an `XCUIElement` represented by the given `KeyPath`
    /// which matches the given dynamic value. The returned element is guaranteed to exist
    /// when this function returns and can be safely interacted with.
    ///
    /// This is the preferred way to interact with UI elements, as not waiting for them to exist
    /// is a common source of flaky test failures due to laggy interactions in slow execution
    /// environments, such as a virtual instance in a CI pipeline.
    ///
    /// ```
    /// // Fetch an imaginary cell at row 20
    /// let cell = try await ExampleScreen.element(\.exampleCell, value: 20)
    /// cell.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         A resolved `XCUIElement` whose existence has been ensured
    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: UnsignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }
}
