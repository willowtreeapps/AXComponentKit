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
