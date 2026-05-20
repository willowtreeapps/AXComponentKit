import AXComponentKitTestSupport
import XCTest

@MainActor
final class SettingsScreenTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
        try await FirstTabScreen.navigator.navigate(toTab: \.settings)
    }

    func testSettingsScreenExists() async throws {
        try await SettingsScreen.exists(timeout: .seconds(15))
    }

    func testAllTogglesExist() async throws {
        try await SettingsScreen.element(\.notificationsToggle)
        try await SettingsScreen.element(\.darkModeToggle)
        try await SettingsScreen.element(\.locationToggle)
        try await SettingsScreen.element(\.analyticsToggle)
    }

    func testStaticComponentsExist() async throws {
        try await SettingsScreen.element(\.versionLabel)
        try await SettingsScreen.element(\.supportEmail)
        try await SettingsScreen.element(\.privacyButton)
        try await SettingsScreen.element(\.termsButton)
        try await SettingsScreen.element(\.profileButton)
    }

    func testScrollViewExists() async throws {
        try await SettingsScreen.element(\.settingsList)
    }

    func testCanNavigateToProfile() async throws {
        try await SettingsScreen.navigator.navigateToProfile()
        try await ProfileScreen.exists()
    }

    func testProfileScreenHasFields() async throws {
        try await SettingsScreen.navigator.navigateToProfile()
        try await ProfileScreen.element(\.profileField, value: "name")
        try await ProfileScreen.element(\.profileField, value: "email")
        try await ProfileScreen.element(\.profileField, value: "phone")
    }

    func testProfileCanBeDismissed() async throws {
        let profileNavigator = try await SettingsScreen.navigator.navigateToProfile()
        try await profileNavigator.dismiss()
        try await SettingsScreen.exists()
    }
}
