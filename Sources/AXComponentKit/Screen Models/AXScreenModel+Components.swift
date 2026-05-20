import Foundation

public extension AXScreen {
    // MARK: Static Component

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
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
    /// - Parameter path: keyPath to the desired scrollView
    /// - Returns: an  `AXScrollView` that can be used for `XCUIElement` queries
    static func component(
        _ path: KeyPath<Self, AXScrollView>
    ) -> AXComponent {
        .init(stringLiteral: Self()[keyPath: path].id)
    }

    // MARK: Dynamic Component

    /// Fetches an `AXComponent` from an instance of `Self` defined by the given keyPath.
    /// The value should be something unique to the component, such as a row index or UUID string.
    ///
    /// - Parameter path: keyPath to the desired dynamic component
    /// - Parameter value: the dynamic value for which the component should resolve from
    /// - Returns: an  `AXComponent` that can be used for `XCUIElement` queries
    static func component<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value
    ) -> AXComponent where Value: AXIdentifierConvertible {
        Self()[keyPath: path].resolve(value)
    }
}
