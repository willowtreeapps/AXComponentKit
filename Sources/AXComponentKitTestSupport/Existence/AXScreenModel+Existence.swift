import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreenModel {
    static func exists(
        timeout: Measurement<UnitDuration> = .seconds(10),
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) async {
        _ = XCUIApplication()
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
