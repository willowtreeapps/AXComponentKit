import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == FirstTabScreen {
    @discardableResult
    func navigateToDetailScreen(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await navigate(file: file, line: line) { screen in
            try await screen.tap(\.detailButton, file: file, line: line)
        }
    }
}
