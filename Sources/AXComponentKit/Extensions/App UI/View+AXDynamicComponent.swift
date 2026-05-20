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
    ) -> some View where Model: AXScreen, Value: AXIdentifierConvertible {
        accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
    }

    /// Assigns an accessibility identifier only when the value is non-nil.
    ///
    /// When `value` is `nil`, no `accessibilityIdentifier` is applied and the
    /// element is invisible to `AXDynamicComponent`-based test queries. Use this
    /// when the view may be in a state (e.g. loading, placeholder) where it should
    /// not participate in automation.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value, or `nil` to suppress the identifier.
    /// - Returns:
    ///         The view, with an `accessibilityIdentifier` applied only if `value` is non-nil.
    @ViewBuilder
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value?
    ) -> some View where Model: AXScreen, Value: AXIdentifierConvertible {
        if let value {
            accessibilityIdentifier(Model()[keyPath: path].resolve(value).id)
        } else {
            self
        }
    }

    /// Assigns an accessibility identifier with a custom prefix prepended to
    /// the component's standard prefix.
    ///
    /// Produces an identifier of the form `"{prefix}-{componentPrefix}_{value}"`.
    /// Use this to distinguish elements that share a component definition but
    /// represent a different semantic state — for example, loading shimmers
    /// vs loaded content.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXDynamicComponent`.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    ///   - prefix:
    ///         A distinguishing prefix to prepend to the component's standard prefix.
    /// - Returns:
    ///         The view after applying the prefixed `accessibilityIdentifier`.
    func automationComponent<Model, Value>(
        _ path: KeyPath<Model, AXDynamicComponent<Value>>,
        value: Value,
        prefix: String
    ) -> some View where Model: AXScreen, Value: AXIdentifierConvertible {
        let component = Model()[keyPath: path]
        let prefixedName = [prefix, component.prefix].filter { !$0.isEmpty }.joined(separator: "-")
        return accessibilityIdentifier("\(prefixedName)_\(value.automationIdentifier)")
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the given `AXDynamicComponent`.
    ///
    /// - Parameters:
    ///   - component:
    ///         An `AXDynamicComponent` that provides an identity for the modified view.
    ///   - value:
    ///         The dynamic value to use while resolving the component.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Value>(
        _ component: AXDynamicComponent<Value>,
        value: Value
    ) -> some View where Value: AXIdentifierConvertible {
        accessibilityIdentifier(component.resolve(value).id)
    }
}
