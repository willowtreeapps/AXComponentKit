import AXComponentKit
import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss

    private let fields = ["name", "email", "phone"]

    @State private var name = "Jane Doe"
    @State private var email = "jane@example.com"
    @State private var phone = "555-1234"

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $name)
                        .automationComponent(\ProfileScreen.profileField, value: "name")
                    TextField("Email", text: $email)
                        .automationComponent(\ProfileScreen.profileField, value: "email")
                    TextField("Phone", text: $phone)
                        .automationComponent(\ProfileScreen.profileField, value: "phone")
                }

                Section {
                    Button("Save") {}
                        .automationComponent(\ProfileScreen.saveButton)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                    .automationComponent(\ProfileScreen.closeButton)
                }
            }
        }
        .automationScreen(ProfileScreen.self)
    }
}
