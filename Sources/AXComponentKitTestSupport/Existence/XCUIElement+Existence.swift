import AXComponentKit
import XCTest

@MainActor
internal extension XCUIElement {
    /// Synchronously ensures that the element has come into existence,
    /// throwing an error otherwise if the timeout expires. This is a convenience
    /// function internal to `AXComponentKit` and is meant to provide a shorthand
    /// for ensuring an element's existence and throwing errors in a consistent pattern.
    ///
    /// ```
    /// // These are effectively equivalent:
    /// _ = try aButton.awaitingExistence()
    /// _ = try await ExampleScreen.element(\.aButton)
    /// ```
    ///
    /// - Parameters:
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - message:
    ///         Optional custom message to display as the failure description
    ///         if the screen is not found
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///     A resolved `XCUIElement` with no guarantees about its existence
    func awaitingExistence(
        timeout: Measurement<UnitDuration> = .seconds(10),
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Self {
        if !waitForExistence(timeout: timeout.timeInterval) {
            let output = message() ?? "Element not found matching identifier: \"\(identifier)\""
            throw AXFailure(output, file: file, line: line)
        }
        return self
    }
}
