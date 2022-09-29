import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    static func assumedElement(
        _ path: KeyPath<Self, AXComponent>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement {
        let identifier = Self.component(path).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    // MARK: Dynamic Components

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    static func assumedElement<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = component.resolve(value).id
        return assumedElement(matching: identifier, file: file, line: line)
    }

    // MARK: Dynamic Components + StringProtocol

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: StringProtocol {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    // MARK: Dynamic Components + SignedInteger

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: SignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    // MARK: Dynamic Components + UnsignedInteger

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: UnsignedInteger {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier, file: file, line: line)
        return element
    }

    static func assumedElement(
        _ path: KeyPath<Self, XCUIElement>,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> XCUIElement {
        Self()[keyPath: path]
    }

    internal static func assumedElement(
        matching identifier: String,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> XCUIElement {
        XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: identifier)
            .firstMatch
    }
}
