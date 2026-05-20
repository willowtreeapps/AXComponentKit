import AXComponentKit
import SwiftUI

@main
struct AXComponentKitSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .automationOptimized()
        }
    }
}
