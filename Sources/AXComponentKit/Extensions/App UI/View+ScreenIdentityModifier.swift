import SwiftUI

private struct ScreenIdentityModifier: ViewModifier {
    let identifier: String

    func body(content: Content) -> some View {
        content.background(
            Color.clear
                .accessibilityElement(children: .contain)
                .accessibilityIdentifier(identifier)
        )
    }
}

public extension View {
    /// Sets the `ScreenIdentifier` on a view, which is used to
    /// verify the app's location defined in
    /// `AXScreenNavigator.performNavigation(...`.
    ///
    /// This modifier should be set only on views that act as a viewController/"screen"
    /// and is not intended for use on contained views.
    func automationScreen<Model>(
        _ modelType: Model.Type
    ) -> some View where Model: AXScreen {
        modifier(ScreenIdentityModifier(identifier: modelType.screenIdentifier))
    }
}
