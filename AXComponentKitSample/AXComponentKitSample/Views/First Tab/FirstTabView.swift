import AXComponentKit
import SwiftUI

struct FirstTabView: View {
    @State
    private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Push Detail") {
                    path.append(0)
                }
                .buttonStyle(.borderedProminent)
                .automationComponent(\FirstTabScreen.detailButton)
            }
            .automationScreen(FirstTabScreen.self)
            .navigationTitle("First Tab")
            .navigationDestination(for: Int.self) { _ in
                DetailView()
            }
        }
    }
}
