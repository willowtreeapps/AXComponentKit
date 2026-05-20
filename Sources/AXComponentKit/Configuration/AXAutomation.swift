import Foundation

/// Provides detection and optimization for AXComponentKit automation test runs.
public enum AXAutomation {
    package static let runnerArgument = "-AXComponentKitRunnerActive"

    /// Whether the app was launched by an AXComponentKit test runner.
    public static var isActive: Bool {
        ProcessInfo.processInfo.arguments.contains(runnerArgument)
    }

    /// Suppresses animations across UIKit, Core Animation, and SwiftUI
    /// when the automation runner is active. No-op in production.
    ///
    /// Call this from `AppDelegate.application(_:didFinishLaunchingWithOptions:)`
    /// or from your SwiftUI `App.init()` for UIKit/hybrid apps. For pure SwiftUI
    /// apps, prefer the `.automationOptimized()` view modifier instead.
    @MainActor
    public static func suppressAnimationsIfNeeded() {
        guard isActive else { return }
        #if canImport(UIKit)
        AnimationSuppressor.shared.activate()
        #endif
    }

    @available(*, deprecated, renamed: "suppressAnimationsIfNeeded")
    @MainActor
    public static func optimizeIfNeeded() {
        suppressAnimationsIfNeeded()
    }
}
