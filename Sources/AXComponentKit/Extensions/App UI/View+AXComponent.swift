import SwiftUI

public extension View {
    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXComponent` identified by the given key path.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXComponent`.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent<Model>(
        _ path: KeyPath<Model, AXComponent>
    ) -> some View where Model: AXScreen {
        accessibilityIdentifier(Model()[keyPath: path].id)
    }

    /// Assigns an accessibility identifier according to what is defined
    /// in the given `AXComponent`.
    ///
    /// - Parameters:
    ///   - component:
    ///         An `AXComponent` that provides an identity for the modified view.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationComponent(_ component: AXComponent?) -> some View {
        accessibilityIdentifier(component?.id ?? "undefined")
    }
}
