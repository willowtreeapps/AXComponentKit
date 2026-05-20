import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct SettingsScreen {
    let notificationsToggle: AXComponent = "settings-notifications-toggle"
    let darkModeToggle: AXComponent = "settings-dark-mode-toggle"
    let locationToggle: AXComponent = "settings-location-toggle"
    let analyticsToggle: AXComponent = "settings-analytics-toggle"
    let versionLabel: AXComponent = "settings-version-label"
    let privacyButton: AXComponent = "settings-privacy-button"
    let termsButton: AXComponent = "settings-terms-button"
    let profileButton: AXComponent = "settings-profile-button"
    let settingsList: AXScrollView = "settings-list-scroll-view"
    let supportEmail: AXComponent = AXComponent(prefix: "settings", "support-email-label")
}
