import AXComponentKit
import Foundation
import XCTest

public enum ScrollDirection {
    case up
    case down
    case left
    case right
}

public extension AXScreenNavigator {
    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - elementPath:
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXComponent>,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        let target = Source.assumedElement(elementPath, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - elementPath:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: AXDynamicValue {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - elementPath:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: SignedInteger {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - elementPath:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: UnsignedInteger {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - elementPath:
    ///         `KeyPath` relative to `Self` that identifies an `AXDynamicComponent`
    ///   - value:
    ///         The dynamic value to use while resolving the component
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: StringProtocol {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    /// Scrolls the given scroll view in the specified direction until the desired
    /// `XCUIElement` comes into existence. If the element is not found before
    /// the timeout expires, an error is thrown.
    ///
    /// - Parameters:
    ///   - direction:
    ///         The direction in which the scroll view should be scrolled.
    ///         The default is `.down`.
    ///   - element:
    ///         The `XCUIElement` being searched for
    ///   - path:
    ///         The key path that identifies an `AXScrollView` which contains `element`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    func scroll(
        _ direction: ScrollDirection = .down,
        to element: XCUIElement,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        let start = Date()

        while Date().timeIntervalSince(start) < timeout.timeInterval {
            if element.exists {
                return
            }

            let scrollView = try await Source.element(path, file: file, line: line)
            let transaction = ScrollTransaction(direction: direction)
            let start = scrollView.coordinate(withNormalizedOffset: transaction.source)
            let end = scrollView.coordinate(withNormalizedOffset: transaction.destination)

            start.press(
                forDuration: 0.1,
                thenDragTo: end,
                withVelocity: .default,
                thenHoldForDuration: 0.1
            )
        }

        throw AXFailure("Scrolling timed out. Element not found.", file: file, line: line)
    }
}
