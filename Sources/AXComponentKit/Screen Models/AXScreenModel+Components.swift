import Foundation

public extension AXScreen {
    // MARK: Static Component

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired component
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component(
        _ path: KeyPath<Self, AXComponent>
    ) -> AXComponent {
        Self()[keyPath: path]
    }

    // MARK: ScrollView

    /// Fetches an `AXScrollView` from an instance of `Self` defined by the given keyPath.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired scrollView
    /// - Returns: an  `AXScrollView` that can be used for `XCUIElement` queries
    static func component(
        _ path: KeyPath<Self, AXScrollView>
    ) -> AXComponent {
        .init(stringLiteral: Self()[keyPath: path].id)
    }

    // MARK: AXDynamicValue

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    /// The value should be something unique to the component, such as a row index or UUID string.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired dynamic component
    /// - Parameter value: the dynamic value for which the component should resolve from
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: AXDynamicValue {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: StringProtocol

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    /// The value should be something unique to the component, such as a row index or UUID string.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired dynamic component
    /// - Parameter value: the dynamic value for which the component should resolve from
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: StringProtocol {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: Signed Integer

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    /// The value should be something unique to the component, such as a row index or UUID string.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired dynamic component
    /// - Parameter value: the dynamic value for which the component should resolve from
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: SignedInteger {
        Self()[keyPath: path].resolve(value)
    }

    // MARK: Unsigned Integer

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    /// The value should be something unique to the component, such as a row index or UUID string.
    ///
    /// Generally only used for implementation details of helper functions and shouldn't be called
    /// directly from application code or from UI tests.
    ///
    /// - Parameter path: keyPath to the desired dynamic component
    /// - Parameter value: the dynamic value for which the component should resolve from
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: UnsignedInteger {
        Self()[keyPath: path].resolve(value)
    }
}
