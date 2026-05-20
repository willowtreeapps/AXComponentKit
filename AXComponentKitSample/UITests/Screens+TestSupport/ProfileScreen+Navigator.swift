import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == ProfileScreen {
    @discardableResult
    func save(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<ProfileScreen> {
        try await navigate(to: ProfileScreen.self, file: file, line: line) { screen in
            try await screen.tap(\.saveButton, file: file, line: line)
        }
    }
}
