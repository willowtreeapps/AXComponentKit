import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreenModel {

    static func assumedElement(
        _ path: KeyPath<Self, AXComponent>
    ) -> XCUIElement {
        let identifier = Self.component(path).id
        return assumedElement(matching: identifier)
    }

    // MARK: Dynamic Components

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        return assumedElement(matching: identifier)
    }

    static func assumedElement<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = component.resolve(value).id
        return assumedElement(matching: identifier)
    }

    // MARK: Dynamic Components + StringProtocol

    static func assumedElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        file: StaticString = #file,
        line: UInt = #line
    ) -> XCUIElement where Value: StringProtocol {
        let identifier = Self.component(path, value: value).id
        let element = assumedElement(matching: identifier)
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
        let element = assumedElement(matching: identifier)
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
        let element = assumedElement(matching: identifier)
        return element
    }

    static func assumedElement(
        _ path: KeyPath<Self, XCUIElement>
    ) -> XCUIElement {
        Self()[keyPath: path]
    }

    internal static func assumedElement(
        matching identifier: String
    ) -> XCUIElement {
        XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: identifier)
            .firstMatch
    }
}
