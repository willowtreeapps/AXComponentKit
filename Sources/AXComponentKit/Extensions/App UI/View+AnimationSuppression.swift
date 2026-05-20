import SwiftUI

public extension View {
    /// Suppresses animations across UIKit, Core Animation, and SwiftUI
    /// when the app is launched by an AXComponentKit test runner.
    ///
    /// In production (when the runner flag is absent), this is a no-op
    /// with zero runtime cost.
    ///
    /// Apply this modifier at your app's root view:
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .automationOptimized()
    ///         }
    ///     }
    /// }
    /// ```
    func automationOptimized() -> some View {
        modifier(AutomationOptimizedModifier())
    }
}

private struct AutomationOptimizedModifier: ViewModifier {
    @State private var didActivate = false

    func body(content: Content) -> some View {
        let isOptimized = AXAutomation.isActive
        content
            .transaction { transaction in
                if isOptimized { transaction.disablesAnimations = true }
            }
            .onAppear {
                guard isOptimized, !didActivate else { return }
                didActivate = true
                AXAutomation.suppressAnimationsIfNeeded()
            }
    }
}
