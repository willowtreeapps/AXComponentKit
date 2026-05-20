import AXComponentKit
import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var locationEnabled = true
    @State private var analyticsEnabled = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                        .automationComponent(\SettingsScreen.notificationsToggle)
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .automationComponent(\SettingsScreen.darkModeToggle)
                    Toggle("Location Services", isOn: $locationEnabled)
                        .automationComponent(\SettingsScreen.locationToggle)
                    Toggle("Analytics", isOn: $analyticsEnabled)
                        .automationComponent(\SettingsScreen.analyticsToggle)
                }

                Section("Account") {
                    Button("View Profile") {
                        showProfile = true
                    }
                    .automationComponent(\SettingsScreen.profileButton)
                }

                Section("Legal") {
                    Button("Privacy Policy") {}
                        .automationComponent(\SettingsScreen.privacyButton)
                    Button("Terms of Service") {}
                        .automationComponent(\SettingsScreen.termsButton)
                }

                Section("Support") {
                    Text("support@example.com")
                        .automationComponent(\SettingsScreen.supportEmail)
                }

                Section("About") {
                    Text("Version 1.0.0")
                        .automationComponent(\SettingsScreen.versionLabel)
                }
            }
            .automationScrollView(\SettingsScreen.settingsList)
            .navigationTitle("Settings")
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
        .automationScreen(SettingsScreen.self)
    }
}
