import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    // MARK: AXDynamicValue

    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: StringProtocol

    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: StringProtocol {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: SignedInteger

    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: SignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }

    // MARK: UnsignedInteger

    @discardableResult
    static func element<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Value: UnsignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        let message = "Element not found with identifier: \"\(identifier)\""
        return try element.awaitingExistence(timeout: timeout, message, file: file, line: line)
    }
}
