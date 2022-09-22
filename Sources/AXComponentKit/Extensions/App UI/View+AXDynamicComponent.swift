import SwiftUI

public extension View {
    // MARK: AXDynamicValue

    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreenModel, Value: AXDynamicValue {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: AXDynamicValue {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: StringProtocol

    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreenModel, Value: StringProtocol {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: StringProtocol {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: Signed Integer

    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreenModel, Value: SignedInteger {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: SignedInteger {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: Unsigned Integer

    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreenModel, Value: UnsignedInteger {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: UnsignedInteger {
        accessibilityIdentifier(component.resolve(value).id)
    }
}
