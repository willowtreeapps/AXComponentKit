import SwiftUI

public extension View {
    /// Assigns an accessibility identifier according to what is defined
    /// in the `AXScrollView` identified by the given key path.
    ///
    /// The scrollview is treated as a container and does not override
    /// the identities of descendent elements in the view tree.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to some `AXScreen` that identifies an `AXScrollView`.
    /// - Returns:
    ///         The view after applying the `accessibilityIdentifier` modifier.
    func automationScrollView<Model>(
        _ path: KeyPath<Model, AXScrollView>
    ) -> some View where Model: AXScreen {
        accessibilityIdentifier(Model()[keyPath: path].id)
            .accessibilityElement(children: .contain)
    }
}
