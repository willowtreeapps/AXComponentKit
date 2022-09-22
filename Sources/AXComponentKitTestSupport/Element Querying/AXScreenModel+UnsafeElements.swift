import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreenModel {
    static func unsafeElement(
        _ path: KeyPath<Self, AXComponent>
    ) -> XCUIElement {
        let identifier = Self.component(path).id
        return unsafeElement(matching: identifier)
    }

    static func unsafeElement<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = Self.component(path, value: value).id
        return unsafeElement(matching: identifier)
    }

    static func unsafeElement<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> XCUIElement where Value: AXDynamicValue {
        let identifier = component.resolve(value).id
        return unsafeElement(matching: identifier)
    }

    static func unsafeElement(
        _ path: KeyPath<Self, XCUIElement>
    ) -> XCUIElement {
        Self()[keyPath: path]
    }

    internal static func unsafeElement(
        matching identifier: String
    ) -> XCUIElement {
        XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: identifier)
            .firstMatch
    }
}
