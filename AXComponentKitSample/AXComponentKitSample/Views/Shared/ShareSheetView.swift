import AXComponentKit
import SwiftUI

struct ShareSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var message = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Message") {
                    TextField("Add a message…", text: $message, axis: .vertical)
                        .automationComponent(\ShareScreen.messageField)
                }

                Section {
                    Button("Send") {
                        dismiss()
                    }
                    .automationComponent(\ShareScreen.sendButton)
                }
            }
            .navigationTitle("Share")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .automationComponent(\ShareScreen.dismissButton)
                }
            }
        }
        .automationScreen(ShareScreen.self)
    }
}
