import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Returns the first element whose accessibility identifier begins with the dynamic
    /// component's prefix, regardless of the specific value suffix. Waits for existence
    /// before returning.
    ///
    /// Use when the exact dynamic value is not known at test time — for example, tapping
    /// the first item in a list of server-returned cards or rows.
    ///
    /// ```swift
    /// let card = try await CatalogScreen.firstElement(anyOf: \.categoryCard)
    /// card.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
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
    ///         The first `XCUIElement` whose identifier begins with the component's prefix,
    ///         guaranteed to exist when this function returns.
    @discardableResult
    static func firstElement<Value>(
        anyOf path: KeyPath<Self, AXDynamicComponent<Value>>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: AXIdentifierConvertible {
        let prefix = Self()[keyPath: path].prefix
        let predicate = NSPredicate(format: "identifier BEGINSWITH %@", prefix)
        let element = XCUIApplication()
            .descendants(matching: .any)
            .matching(predicate)
            .firstMatch
        let message = "No element found with identifier beginning with: \"\(prefix)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    /// Taps the first element whose accessibility identifier begins with the dynamic
    /// component's prefix, regardless of the specific value suffix. Waits for existence
    /// before tapping.
    ///
    /// Use when the exact dynamic value is not known at test time — for example, tapping
    /// the first item in a list of server-returned cards or rows.
    ///
    /// ```swift
    /// try await CatalogScreen.tapFirst(anyOf: \.categoryCard)
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    static func tapFirst<Value>(
        anyOf path: KeyPath<Self, AXDynamicComponent<Value>>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: AXIdentifierConvertible {
        let element = try await firstElement(anyOf: path, timeout: timeout, file: file, line: line)
        element.tap()
    }

    /// Returns the first element whose accessibility identifier begins with the
    /// prefixed dynamic component's identifier prefix, regardless of the specific
    /// value suffix. Waits for existence before returning.
    ///
    /// Use when the writer-side view modifier applied a custom prefix via
    /// `automationComponent(_:value:prefix:)` and the exact dynamic value is
    /// not known at test time.
    ///
    /// ```swift
    /// let card = try await CatalogScreen.firstElement(anyOf: \.categoryCard, prefix: "featured")
    /// card.tap()
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - prefix:
    ///         The custom prefix that was supplied to the writer-side view modifier.
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
    ///         The first `XCUIElement` whose identifier begins with the prefixed component prefix,
    ///         guaranteed to exist when this function returns.
    @discardableResult
    static func firstElement<Value>(
        anyOf path: KeyPath<Self, AXDynamicComponent<Value>>,
        prefix: String,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: AXIdentifierConvertible {
        let component = Self()[keyPath: path]
        let prefixedName = [prefix, component.prefix].filter { !$0.isEmpty }.joined(separator: "-")
        let predicate = NSPredicate(format: "identifier BEGINSWITH %@", prefixedName)
        let element = XCUIApplication()
            .descendants(matching: .any)
            .matching(predicate)
            .firstMatch
        let message = "No element found with identifier beginning with: \"\(prefixedName)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    /// Taps the first element whose accessibility identifier begins with the
    /// prefixed dynamic component's identifier prefix, regardless of the specific
    /// value suffix. Waits for existence before tapping.
    ///
    /// ```swift
    /// try await CatalogScreen.tapFirst(anyOf: \.categoryCard, prefix: "featured")
    /// ```
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - prefix:
    ///         The custom prefix that was supplied to the writer-side view modifier.
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    static func tapFirst<Value>(
        anyOf path: KeyPath<Self, AXDynamicComponent<Value>>,
        prefix: String,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: AXIdentifierConvertible {
        let element = try await firstElement(anyOf: path, prefix: prefix, timeout: timeout, file: file, line: line)
        element.tap()
    }
}
