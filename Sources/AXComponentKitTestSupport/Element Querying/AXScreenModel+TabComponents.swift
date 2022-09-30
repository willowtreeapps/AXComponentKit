import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Asynchronously fetches an `XCUIElement` represented by the given `KeyPath`.
    /// The returned element is guaranteed to exist when this function returns and can be
    /// safely interacted with.
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
    ///         `KeyPath` relative to `Self` that identifies an `AXComponent`
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
    static func element<Screen>(
        _ path: KeyPath<Self, AXTabComponent<Screen>>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Screen: AXScreen {
        let component = Self()[keyPath: path]
        let tabItem = assumedElement(path, file: file, line: line)
        _ = try tabItem.awaitingExistence(timeout: timeout, "\"\(component.name)\" tab not found", file: file, line: line)
        return tabItem
    }

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
    static func assumedElement<Screen>(
        _ path: KeyPath<Self, AXTabComponent<Screen>>,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> XCUIElement where Screen: AXScreen {
        let component = Self()[keyPath: path]
        let predicate = NSPredicate(format: "label LIKE[c] '\(component.name)'")
        let tabItem = XCUIApplication().tabBars.buttons.matching(predicate).firstMatch
        return tabItem
    }
}
