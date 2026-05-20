import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == SettingsScreen {
    @discardableResult
    func navigateToProfile(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<ProfileScreen> {
        try await navigate(to: ProfileScreen.self, file: file, line: line) { screen in
            try await screen.tap(\.profileButton, file: file, line: line)
        }
    }
}
