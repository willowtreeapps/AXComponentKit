import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension FirstTabScreen {
    @discardableResult
    static func navigateToDetailScreen(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await Navigator().navigateToDetailScreen(file: file, line: line)
    }
}

extension AXScreenNavigator where Source == FirstTabScreen {
    @discardableResult
    func navigateToDetailScreen(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await performNavigation(file: file, line: line) { screen in
            try await screen.element(\.detailButton).tap()
        }
    }
}
