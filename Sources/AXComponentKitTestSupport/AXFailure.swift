import Foundation
import XCTest

/// An easy to throw error that can be caught by XCTest automatically
/// while also reporting a test failure at the specified file and line
final class AXFailure: NSError {
    /// Creates a new error that will fail at the given file/line with
    /// the specified message
    ///
    /// - Parameters:
    ///   - message:
    ///         The message to display as the failure description
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    init(_ message: String, file: StaticString, line: UInt) {
        XCTFail(message, file: file, line: line)
        super.init(
            domain: "com.axcomponentkit.testsupport",
            code: 1,
            userInfo: [
                NSLocalizedDescriptionKey: message,
            ]
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
}
