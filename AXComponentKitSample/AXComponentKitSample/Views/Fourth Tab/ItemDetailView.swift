import AXComponentKit
import SwiftUI

struct ItemDetailView: View {
    let itemIndex: Int
    let category: Category

    @State private var showShare = false

    var body: some View {
        Form {
            Section {
                Text("Item \(itemIndex) — \(category.displayName)")
                    .automationComponent(\ItemDetailScreen.titleLabel)
                Text("This is a detailed description of item \(itemIndex) in the \(category.displayName) category.")
                    .automationComponent(\ItemDetailScreen.descriptionLabel)
            }

            Section {
                Button("Share") {
                    showShare = true
                }
                .automationComponent(\ItemDetailScreen.shareButton)
            }
        }
        .navigationTitle("Item \(itemIndex)")
        .sheet(isPresented: $showShare) {
            ShareSheetView()
        }
        .automationScreen(ItemDetailScreen.self)
    }
}
