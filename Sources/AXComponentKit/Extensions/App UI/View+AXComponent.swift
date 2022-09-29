import SwiftUI

public extension View {
    func automationComponent<Model>(
        _ path: KeyPath<Model, AXComponent>
    ) -> some View where Model: AXScreenModel {
        accessibilityIdentifier(Model()[keyPath: path].id)
    }

    func automationComponent(_ component: AXComponent?) -> some View {
        accessibilityIdentifier(component?.id ?? "undefined")
    }
}

// MARK: AXScrollView

public extension View {
    func automationScrollView<Model>(
        _ path: KeyPath<Model, AXScrollView>
    ) -> some View where Model: AXScreenModel {
        accessibilityIdentifier(Model()[keyPath: path].id)
            .accessibilityElement(children: .contain)
    }

    func automationScrollView(_ component: AXScrollView?) -> some View {
        accessibilityIdentifier(component?.id ?? "undefined")
            .accessibilityElement(children: .contain)
    }
}
