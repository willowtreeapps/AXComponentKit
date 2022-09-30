import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Asynchronously ensures that the screen has come into existence,
    /// throwing an error otherwise if the timeout expires.
    ///
    /// ```
    /// try await ExampleScreen.exists()
    /// try await ExampleScreen.exists(timeout: .seconds(30)) // custom timeout
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
    static func exists(
        timeout: Measurement<UnitDuration> = .seconds(10),
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        _ = try XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: screenIdentifier)
            .firstMatch
            .awaitingExistence(
                timeout: timeout,
                message() ?? "Screen not found matching identifier: \"\(screenIdentifier)\"",
                file: file,
                line: line
            )
    }
}
