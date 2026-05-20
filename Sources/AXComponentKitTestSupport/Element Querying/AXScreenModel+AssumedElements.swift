import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Fetches an `XCUIElement` represented by the given `KeyPath`.
    ///
    /// This element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen. For most use cases,
    /// prefer `element(_:timeout:file:line)` as it gives you assurances
    /// about the existence of the element before returning.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
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
    /// about the existence of the element on screen. For most use cases,
    /// prefer `element(_:value:timeout:)` as it gives you assurances
    /// about the existence of the element before returning.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXIdentifierConvertible {
        let identifier = Self.component(path, value: value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    /// Fetches an `XCUIElement` represented by the given `AXDynamicComponent`
    /// which matches the given dynamic value.
    ///
    /// The returned element is assumed to exist, therefore no guarantees are made
    /// about the existence of the element on screen.
    ///
    /// - Parameters:
    ///   - component:
    ///         An `AXDynamicComponent` to resolve
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    static func assumedElement<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXIdentifierConvertible {
        let identifier = component.resolve(value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    // MARK: XCUIElement

    /// Fetches an `XCUIElement` represented by the given `KeyPath`.
    ///
    /// Sometimes a protocol extension provides an `XCUIElement` directly
    /// because iOS does not allow managing accessibility identifiers for
    /// the view in question (e.g., a tab bar item or navigation bar element).
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `XCUIElement`
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
