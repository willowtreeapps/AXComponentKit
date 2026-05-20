import AXComponentKit
import XCTest

public extension XCUIApplication {
    /// Returns a new `XCUIApplication` pre-configured with AXComponentKit's
    /// launch arguments for animation suppression and test optimization.
    static func automationConfigured() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments += [AXAutomation.runnerArgument]
        return app
    }

    /// Launches a pre-configured application for automation testing.
    ///
    /// This is the recommended way to launch the app in UI tests:
    /// ```swift
    /// override func setUp() async throws {
    ///     XCUIApplication.automationLaunch()
    /// }
    /// ```
    @discardableResult
    static func automationLaunch() -> XCUIApplication {
        let app = automationConfigured()
        app.launch()
        return app
    }
}
