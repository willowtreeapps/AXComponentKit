import AXComponentKit
import SwiftUI

struct FirstTabView: View {
    @State
    private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Push Detail") {
                    // Do stuff
                    path.append(DetailScreenView())
                }
                .buttonStyle(.borderedProminent)
                .automationComponent(\FirstTabScreen.detailButton)
            }
            .automationScreen(FirstTabScreen.self)
            .navigationTitle("First Tab")
            .navigationDestination(for: DetailScreenView.self) { view in
                view
            }
        }
    }
}
