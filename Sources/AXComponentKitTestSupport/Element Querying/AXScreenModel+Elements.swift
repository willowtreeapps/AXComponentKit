import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    @discardableResult
    static func element(
        _ path: KeyPath<Self, AXComponent>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement {
        let identifier = Self.component(path).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    @discardableResult
    static func element(
        _ path: KeyPath<Self, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement {
        let identifier = Self.component(path).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }
}
