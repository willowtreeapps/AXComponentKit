import AXComponentKit
import XCTest

@MainActor
internal extension XCUIElement {
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
