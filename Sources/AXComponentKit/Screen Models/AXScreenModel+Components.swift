import Foundation

public extension AXScreenModel {
    // MARK: Static Component

    static func component(
        _ path: KeyPath<Self, AXComponent>
    ) -> AXComponent {
        Self()[keyPath: path]
    }

    // MARK: AXDynamicValue

    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: AXDynamicValue {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: StringProtocol

    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: StringProtocol {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: Signed Integer

    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: SignedInteger {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: Unsigned Integer

    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: UnsignedInteger {
        Self()[keyPath: path].resolve(value)
    }
}
