import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == ItemDetailScreen {
    @discardableResult
    func navigateToShare(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<ShareScreen> {
        try await navigate(to: ShareScreen.self, file: file, line: line) { screen in
            try await screen.tap(\.shareButton, file: file, line: line)
        }
    }
}
