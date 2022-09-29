import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreenModel {
    @discardableResult
    static func element(
        _ path: KeyPath<Self, AXComponent>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async -> XCUIElement {
        let identifier = Self.component(path).id
        let element = assumedElement(matching: identifier)
        let message = "Element not found with identifier: \"\(identifier)\""
        return element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    @discardableResult
    static func element(
        _ path: KeyPath<Self, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async -> XCUIElement {
        let identifier = Self.component(path).id
        let element = assumedElement(matching: identifier)
        let message = "Element not found with identifier: \"\(identifier)\""
        return element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }
}
