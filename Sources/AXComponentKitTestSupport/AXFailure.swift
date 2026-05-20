import Foundation
import XCTest

/// A test failure error that carries source location for call-site attribution.
///
/// `AXFailure` does not call `XCTFail` in its initializer — failure recording
/// happens at the throw site so that caught errors do not produce spurious
/// test failures.
///
/// `@unchecked Sendable` is safe: all stored properties (`StaticString`, `UInt`)
/// are immutable value types, and `NSError` is itself `@unchecked Sendable`.
final class AXFailure: NSError, @unchecked Sendable {
    let sourceFile: StaticString
    let sourceLine: UInt

    init(_ message: String, file: StaticString, line: UInt) {
        self.sourceFile = file
        self.sourceLine = line
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

extension AXFailure {
    /// Records the failure via `XCTFail` and throws. Call this instead of
    /// constructing + throwing separately so the failure is reported exactly once.
    @MainActor static func fail(
        _ message: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> Never {
        XCTFail(message, file: file, line: line)
        throw AXFailure(message, file: file, line: line)
    }
}
