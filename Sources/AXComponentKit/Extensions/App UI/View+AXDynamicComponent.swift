import SwiftUI

public extension View {
    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreen, Value: AXDynamicValue {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: AXDynamicValue {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: StringProtocol

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreen, Value: StringProtocol {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: StringProtocol {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: Signed Integer

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreen, Value: SignedInteger {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: SignedInteger {
        accessibilityIdentifier(component.resolve(value).id)
    }

    // MARK: Unsigned Integer

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value
    ) -> some View where Model: AXScreen, Value: UnsignedInteger {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXDynamicComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: UnsignedInteger {
        accessibilityIdentifier(component.resolve(value).id)
    }
}
